# dotfiles

Minimal dotfiles for Ubuntu VMs with zsh, tmux, and Oh-My-Zsh configuration.

## Features

- **zsh** as default shell with:
  - Oh-My-Zsh framework
  - Syntax highlighting
  - Auto-suggestions
  - Command correction
- **tmux** with:
  - Ctrl+a as prefix key
  - Mouse support
  - Vi mode
  - Easy config reload (prefix + r)
- **Auto-switch from bash to zsh** (appended to existing .bashrc)
- Automatic backup of existing dotfiles

## Installation

```bash
git clone <your-repo-url> ~/dotfiles
cd ~/dotfiles
chmod +x install.sh
./install.sh
```

## What it does

1. Backs up existing dotfiles to `~/.dotfiles_backup_<timestamp>`
2. Installs zsh, tmux, and required plugins
3. Installs Oh-My-Zsh framework
4. Creates symlinks for configuration files
5. Appends zsh auto-switch to .bashrc (preserving existing configurations)
6. Sets zsh as default shell

## Files

- `install.sh` - Installation script
- `zshrc` - Zsh configuration
- `tmux.conf` - Tmux configuration

## How it handles .bashrc

The installer preserves your existing `.bashrc` and appends a small snippet that:

- Automatically switches to zsh when opening a bash shell
- Only switches if zsh is installed and available
- Won't add duplicate entries if you run the installer multiple times

## Post-installation

After installation, either:

- Log out and log back in, or
- Run `exec zsh` to start using zsh immediately
