# Editor used by CLI
export EDITOR="nvim"
export SUDO_EDITOR="$EDITOR"
. "$HOME/.cargo/env"

#rebar3
export PATH=/home/lami/.cache/rebar3/bin:$PATH
export PATH=/usr/local/android-studio/bin:$PATH

export ANDROID_SDK_ROOT="$HOME/Android/Sdk"

eval "$(starship init bash)"

#aliases
alias c='clear'
alias code='code . -r'

# File system
alias ls='eza -lh --group-directories-first --icons'
alias lsa='ls -a'
alias lt='eza --tree --level=2 --long --icons --git'
alias lta='lt -a'
alias ff="fzf --preview 'batcat --style=numbers --color=always {}'"
alias fd='fdfind'
alias cd='z'

# Directories
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Tools
alias n='nvim'
alias t='tmux attach-session'
alias g='git'
alias d='docker'
alias r='rails'
alias bat='batcat'
alias lzg='lazygit'
alias lzd='lazydocker'

# Git
alias gcm='git commit -m'
alias gcam='git commit -a -m'
alias gcad='git commit -a --amend'

# Compression
compress() { tar -czf "${1%/}.tar.gz" "${1%/}"; }
alias decompress="tar -xzf"

# Convert webm files generated by the Gnome screenshot video recorder to mp4s that are more compatible
webm2mp4() {
  input_file="$1"
  output_file="${input_file%.webm}.mp4"
  ffmpeg -i "$input_file" -c:v libx264 -preset slow -crf 22 -c:a aac -b:a 192k "$output_file"
}

# INIT
if command -v mise &>/dev/null; then
  eval "$(mise activate bash)"
fi

if command -v zoxide &>/dev/null; then
  eval "$(zoxide init --cmd cd bash)"
fi

if command -v fzf &>/dev/null; then
  source /usr/share/bash-completion/completions/fzf
  source /usr/share/doc/fzf/examples/key-bindings.bash
fi

# Technicolor dreams
force_color_prompt=yes
color_prompt=yes

# Simple prompt with path in the window/pane title and carat for typing line
PS1=$'\uf0a9 '
PS1="\[\e]0;\w\a\]$PS1"

# History control
shopt -s histappend
HISTCONTROL=ignoreboth
HISTSIZE=32768
HISTFILESIZE="${HISTSIZE}"

# Autocompletion
source /usr/share/bash-completion/bash_completion

# Set complete path
export PATH="./bin:$HOME/.local/bin:$HOME/.local/share/omakub/bin:$PATH"
set +h
export OMAKUB_PATH="/home/$USER/.local/share/omakub"
