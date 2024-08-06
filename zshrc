# Enable zsh
if [ -t 1 ]; then
  exec zsh
fi

# Set ZSH as default shell if it's not already
if [ -n "$BASH_VERSION" ]; then
  chsh -s $(which zsh)
fi

# Add your custom zsh configuration here
# For example, enable command auto-correction
ENABLE_CORRECTION="true"

# Load zsh-syntax-highlighting
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Load zsh-autosuggestions
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Add your custom aliases
alias ll='ls -lah'

# Source the Oh-My-Zsh configuration if available
if [ -f ~/.oh-my-zsh/oh-my-zsh.sh ]; then
  source ~/.oh-my-zsh/oh-my-zsh.sh
fi
