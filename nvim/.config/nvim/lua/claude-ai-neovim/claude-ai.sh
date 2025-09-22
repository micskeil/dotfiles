#!/bin/bash

# Claude AI Shell Script for Neovim Integration
# This script handles the communication between Neovim and Claude Code

# Check if context file was provided
if [ $# -eq 0 ]; then
  echo '{"error": "No context file provided"}' >&2
  exit 1
fi

CONTEXT_FILE="$1"

# Check if context file exists
if [ ! -f "$CONTEXT_FILE" ]; then
  echo '{"error": "Context file not found"}' >&2
  exit 1
fi

# Read and parse the context
CONTEXT=$(cat "$CONTEXT_FILE")

# Extract data using jq
BUFFER_CONTENT=$(echo "$CONTEXT" | jq -r '.buffer_content // ""')
SELECTED_TEXT=$(echo "$CONTEXT" | jq -r '.selected_text // ""')
PROMPT=$(echo "$CONTEXT" | jq -r '.prompt // ""')
IS_VISUAL=$(echo "$CONTEXT" | jq -r '.is_visual // false')
FILENAME=$(echo "$CONTEXT" | jq -r '.filename // ""')
FILETYPE=$(echo "$CONTEXT" | jq -r '.filetype // ""')
CURSOR_LINE=$(echo "$CONTEXT" | jq -r '.cursor_position.line // 1')
CURSOR_COL=$(echo "$CONTEXT" | jq -r '.cursor_position.col // 1')

# Determine action based on prompt keywords
ACTION="info"
if [[ "$PROMPT" =~ (replace|fix|change|update|modify) ]] && [ "$IS_VISUAL" = "true" ]; then
  ACTION="replace"
elif [[ "$PROMPT" =~ (add|insert|create|generate|write) ]]; then
  ACTION="insert"
elif [[ "$PROMPT" =~ (explain|what|how|why|describe) ]]; then
  ACTION="info"
fi

# Build the Claude Code prompt with context
CLAUDE_PROMPT=""

# Add file context if available
if [ -n "$FILENAME" ] && [ -n "$FILETYPE" ]; then
  CLAUDE_PROMPT+="File: $FILENAME (type: $FILETYPE)
"
fi

# Add cursor position
CLAUDE_PROMPT+="Cursor position: line $CURSOR_LINE, column $CURSOR_COL
"

# Add selected text context if in visual mode
if [ "$IS_VISUAL" = "true" ] && [ -n "$SELECTED_TEXT" ]; then
  CLAUDE_PROMPT+="
Selected text:
\`\`\`$FILETYPE
$SELECTED_TEXT
\`\`\`

"
fi

# Add buffer context (truncated if too long)
BUFFER_LENGTH=${#BUFFER_CONTENT}
if [ $BUFFER_LENGTH -gt 5000 ]; then
  # Get lines around cursor for context
  CONTEXT_LINES=$(echo "$BUFFER_CONTENT" | sed -n "$((CURSOR_LINE - 10)),$((CURSOR_LINE + 10))p")
  CLAUDE_PROMPT+="
Buffer context (around cursor):
\`\`\`$FILETYPE
$CONTEXT_LINES
\`\`\`

"
else
  CLAUDE_PROMPT+="
Full buffer content:
\`\`\`$FILETYPE
$BUFFER_CONTENT
\`\`\`

"
fi

# Add the user's prompt
CLAUDE_PROMPT+="
User request: $PROMPT

"

# Add instructions based on action type
case $ACTION in
"replace")
  CLAUDE_PROMPT+="Please provide a replacement for the selected text. Return ONLY the replacement code without explanations, markdown formatting, or code blocks."
  ;;
"insert")
  CLAUDE_PROMPT+="Please provide code to insert at the cursor position. Return ONLY the code without explanations, markdown formatting, or code blocks."
  ;;
"info")
  CLAUDE_PROMPT+="Please provide an explanation or information. You can use markdown formatting for readability."
  ;;
esac

# Create temporary file for Claude input
TEMP_INPUT=$(mktemp)
echo "$CLAUDE_PROMPT" >"$TEMP_INPUT"

# Call Claude Code with the prompt
CLAUDE_OUTPUT=$(claude <"$TEMP_INPUT" 2>&1)
CLAUDE_EXIT_CODE=$?

# Clean up temp file
rm -f "$TEMP_INPUT"

# Check if Claude command succeeded
if [ $CLAUDE_EXIT_CODE -ne 0 ]; then
  echo "{\"error\": \"Claude command failed: $CLAUDE_OUTPUT\"}" >&2
  exit 1
fi

# Process Claude's response
if [ "$ACTION" = "replace" ] || [ "$ACTION" = "insert" ]; then
  # Remove any markdown code blocks and clean the output
  CLEANED_OUTPUT=$(echo "$CLAUDE_OUTPUT" | sed -E 's/^```[a-zA-Z]*$//' | sed -E 's/^```$//' | sed '/^\s*$/d')
  # Remove leading/trailing whitespace but preserve internal formatting
  CLEANED_OUTPUT=$(echo "$CLEANED_OUTPUT" | sed -e :a -e '/^\s*$/N; s/\n\s*$/\n/; ta')
else
  # For info responses, keep the full output
  CLEANED_OUTPUT="$CLAUDE_OUTPUT"
fi

# Return JSON response
jq -n \
  --arg action "$ACTION" \
  --arg content "$CLEANED_OUTPUT" \
  '{action: $action, content: $content}'

