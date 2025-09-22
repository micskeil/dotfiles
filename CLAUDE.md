# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal dotfiles repository containing configuration files for various development tools and terminal applications. The repository uses a modular structure with separate directories for each application's configuration.

## Directory Structure

- `alacritty/` - Terminal emulator configuration using TOML format with modular imports for theme, font, and font-size
- `bash/` - Bash shell configuration with extensive aliases, environment variables, and tool integrations
- `git/` - Git configuration with aliases and merge tool setup using nvim
- `nvim/` - Neovim configuration using LazyVim framework with custom plugins and keymaps
- `tmux/` - Tmux configuration with Catppuccin theme and vim-like navigation
- `ghostty/` - Ghostty terminal configuration (newer terminal emulator)
- `kanata/` - Keyboard layout configuration
- `yazi/` - File manager configuration

## Key Configuration Architecture

### Neovim Setup
- Uses LazyVim as the base distribution (`nvim/.config/nvim/lua/config/lazy.lua`)
- Custom plugins are organized in `nvim/.config/nvim/lua/plugins/` directory
- Includes Claude Code integration via `claude-code.lua` plugin with floating window configuration
- Uses plugin-based architecture where each plugin file configures specific functionality

### Bash Environment
- Extensive alias system replacing common commands with modern alternatives:
  - `ls` → `eza` (modern ls replacement with icons)
  - `cd` → `z` (zoxide for smart directory jumping)
  - `rm` → `trash-put` (safer deletion)
- Tool integrations: starship prompt, mise version manager, zoxide, fzf
- Custom functions for file compression and video conversion

### Terminal Configuration
- Alacritty uses modular TOML configuration with separate files for theme, font, and font-size
- Tmux configured with Catppuccin theme and vim-style pane navigation
- Both terminals configured for true color support and performance optimization

### Git Workflow
- Uses nvim as the default merge and diff tool
- Global gitignore configured at `/home/lami/.gitignore_global`
- Common aliases: `co` (checkout), `br` (branch), `ci` (commit), `st` (status)

## Common Development Commands

Since this is a dotfiles repository, the primary operations involve:

### Applying Configurations
```bash
# Navigate to specific config directories and create symlinks manually
# Example: ln -s ~/dotfiles/nvim/.config/nvim ~/.config/nvim
```

### Testing Configurations
```bash
# Test bash configuration
source ~/.bashrc

# Test tmux configuration  
tmux source-file ~/.tmux.conf

# Test git configuration
git config --list
```

### Neovim Plugin Management
```bash
# Open nvim and use Lazy.nvim commands
:Lazy sync        # Update all plugins
:Lazy clean       # Remove unused plugins
:Lazy check       # Check for updates
```

## Tool Dependencies

The configurations assume these tools are installed:
- `eza` - Modern ls replacement
- `zoxide` - Smart cd replacement
- `fzf` - Fuzzy finder
- `batcat` - Syntax highlighting cat replacement  
- `starship` - Cross-shell prompt
- `mise` - Version manager
- `lazygit` - Terminal UI for git
- `yazi` - Terminal file manager
- `trash-put` - Safe rm replacement

## Claude Code Integration

Neovim is configured with the claude-code plugin that provides:
- Floating window interface for Claude Code (95% screen coverage)
- Keybindings: `<C-t>` to toggle, `<leader>cC` for continue mode
- Auto-refresh functionality for file changes
- Git root detection for proper working directory

When working with this repository, Claude Code will automatically use the git root as the working directory and can interact with all configuration files through the integrated terminal interface.