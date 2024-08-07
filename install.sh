#!/bin/bash

# Vars
DIR="$HOME/dotfiles"

# Install Oh My Zsh + Plugins
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

## P10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"/themes/powerlevel10k

## Zsh Syntax Highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"/plugins/zsh-syntax-highlighting

## Zsh Autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"/plugins/zsh-autosuggestions

# Symlinks
ln -fs "$DIR"/.zshrc "$HOME"/.zshrc
ln -fs "$DIR"/.p10k.zsh "$HOME"/.p10k.zsh
ln -fs "$DIR"/.gitconfig "$HOME"/.gitconfig
ln -fs "$DIR"/.tmux.conf "$HOME"/.tmux.conf

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
export PATH="/opt/homebrew/bin:$PATH"

## Install brew packages
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

# Install pyenv-pyright
git clone https://github.com/alefpereira/pyenv-pyright.git "$(pyenv root)"/plugins/pyenv-pyright

# Neovim Configuration
if [ ! -d "$HOME/.config/" ]; then
	mkdir -p "$HOME/.config/"
fi

git clone "https://github.com/elianmanzueta/nvim" "$HOME"/.config/nvim
