#!/bin/bash

# Set debugging
set -x

DIR=$PWD

# Install Oh My Zsh!
if [ ! -d $HOME/.oh-my-zsh/ ]; then
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
	echo "Oh My Zsh! Detected - Skipping installation"
fi

# Install Oh My Zsh! Plugins

echo "Installing plugins"
# Zsh Syntax Highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Zsh Autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Symlinks
echo "Configuring symlinks"
ln -fs $DIR/.zshrc $HOME/.zshrc
ln -fs $DIR/.p10k.zsh $HOME/.p10k.zsh
