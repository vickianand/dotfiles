#!/usr/bin/env bash

set -ueo pipefail

_HERE=$(
    cd $(dirname $0)
    pwd
)

_ME=$(whoami)

# Create backup directory
BACKUP_DIR="$HOME/.dotfiles_backup_$(date +%Y%m%d_%H%M%S)"
echo "Creating backup directory: $BACKUP_DIR"
mkdir -p "$BACKUP_DIR"

# Backup existing files if they exist
for file in ~/.tmux.conf ~/.zshrc ~/.bashrc; do
    if [ -f "$file" ]; then
        echo "Backing up $file"
        cp "$file" "$BACKUP_DIR/"
    fi
done

# Update package list once
echo "Updating package list..."
sudo apt-get update

# Install required tools
echo "Installing required tools..."
sudo apt-get install -y wget curl git

# Install zsh
if ! command -v zsh &>/dev/null; then
    echo "zsh could not be found, installing..."
    sudo apt-get install -y zsh
else
    echo "zsh is already installed"
fi

# Install tmux
if ! command -v tmux &>/dev/null; then
    echo "tmux could not be found, installing..."
    sudo apt-get install -y tmux
else
    echo "tmux is already installed"
fi

# Install zsh plugins
echo "Installing zsh plugins..."
sudo apt-get install -y zsh-syntax-highlighting zsh-autosuggestions

# Install Oh-My-Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing Oh-My-Zsh..."
    sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    echo "Oh-My-Zsh is already installed"
fi

# Copy dotfiles to home directory
echo "Installing dotfiles..."
ln -sf ${_HERE}/tmux.conf ~/.tmux.conf
ln -sf ${_HERE}/zshrc ~/.zshrc

# Add zsh switching to bashrc if not already present
if [ -f ~/.bashrc ]; then
    # Check if our zsh switching logic is already in bashrc
    if ! grep -q "# Auto-switch to zsh (added by dotfiles installer)" ~/.bashrc; then
        echo "Adding zsh auto-switch to existing .bashrc..."
        cat >>~/.bashrc <<'EOF'

# Auto-switch to zsh (added by dotfiles installer)
if [ -t 1 ] && command -v zsh &> /dev/null && [ "$SHELL" != "$(which zsh)" ]; then
    export SHELL=$(which zsh)
    exec zsh
fi
EOF
    else
        echo "zsh auto-switch already present in .bashrc"
    fi
else
    # Create a minimal bashrc if it doesn't exist
    echo "Creating new .bashrc with zsh auto-switch..."
    cat >~/.bashrc <<'EOF'
# ~/.bashrc: executed by bash(1) for non-login shells.

# Auto-switch to zsh (added by dotfiles installer)
if [ -t 1 ] && command -v zsh &> /dev/null && [ "$SHELL" != "$(which zsh)" ]; then
    export SHELL=$(which zsh)
    exec zsh
fi
EOF
fi

# Display a message
echo ""
echo "==================================="
echo "Installation complete!"
echo "Backups saved to: $BACKUP_DIR"
echo ""
echo "To start using zsh:"
echo "  - Run: exec zsh"
echo "  - Or simply log out and back in"
echo ""
echo "Your shell will automatically switch to zsh on login."
echo "==================================="
