#!/usr/bin/env bash

set -xueo pipefail

_HERE=$(
	cd $(dirname $0)
	pwd
)

_ME=$(whoami)

# Install zsh
if ! command -v zsh &> /dev/null
then
    echo "zsh could not be found, installing..."
    sudo apt-get update
    sudo apt-get install -y zsh
else
    echo "zsh is already installed"
fi

# Install tmux
if ! command -v tmux &> /dev/null
then
    echo "tmux could not be found, installing..."
    sudo apt-get install -y tmux
else
    echo "tmux is already installed"
fi

# Copy dotfiles to home directory
ln -sf ${_HERE}/tmux.conf ~/.tmux.conf
ln -sf ${_HERE}/zshrc ~/.zshrc

# Change default shell to zsh
sudo chsh -s $(which zsh) $_ME

# Display a message
echo "Installation complete. Please log out and log back in to start using zsh and tmux with the new configuration."
