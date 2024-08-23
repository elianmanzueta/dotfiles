#!/bin/bash

DIR="$HOME/dotfiles"

# Symlinks
ln -fs "$DIR"/.zshrc "$HOME"/.zshrc
ln -fs "$DIR"/.p10k.zsh "$HOME"/.p10k.zsh

# Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
export PATH="/opt/homebrew/bin:$PATH"

brew install gh
brew install neovim
brew install tree
brew install ripgrep
brew install lazygit
brew install tmux
brew install pyenv
brew install pyenv-virtualenv
brew install bat
brew install zoxide
brew install lsd

# Pyenv-pyright
git clone https://github.com/alefpereira/pyenv-pyright.git "$(pyenv root)"/plugins/pyenv-pyright

# Clone neovim configuration
if [ ! -d "$HOME/.config/" ]; then
  mkdir -p "$HOME/.config/"
fi

git clone "https://github.com/elianmanzueta/nvim" "$HOME"/.config/nvim
