#!/bin/bash

# Variables
DIR=$PWD
OS = $(uname -s)

# Install packages
if [ "$(uname -s)" = "Linux" ]; then
	sudo apt-get install curl zsh build-essential git
fi

# Install Oh My Zsh!
if [ ! -d $HOME/.oh-my-zsh/ ]; then
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
	echo "Oh My Zsh! detected - Skipping installation"
fi

# Install Oh My Zsh! Plugins
echo "Installing plugins"

# P10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# Zsh Syntax Highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Zsh Autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Symlinks
echo "Configuring symlinks"
ln -fs $DIR/.zshrc $HOME/.zshrc
ln -fs $DIR/.p10k.zsh $HOME/.p10k.zsh
ln -fs $DIR/.gitconfig $HOME/.gitconfig
ln -fs $DIR/.tmux.conf $HOME/.tmux.conf

# Install Homebrew
if [ ! -d /opt/homebrew ]; then
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
	echo "Homebrew detected - Skipping installation"
fi

case "$OS" in
Darwin)
	export PATH="/opt/homebrew/bin:$PATH"
	;;
Linux) ;;
esac

# Install brew packages
read -p "Install Homebrew packages? [y/n]: " response

if [[ $response =~ [Yy]$ ]]; then
	brew install gh
	brew install neovim
	brew install tree
	brew install ripgrep
	brew install lazygit
	brew install tmux
	brew install pyenv
	brew install pyenv-virtualenv
else
	echo "Skipping package installation"
fi

# Install pyenv
curl https://pyenv.run | bash

# Install pyenv pyright
git clone https://github.com/alefpereira/pyenv-pyright.git $(pyenv root)/plugins/pyenv-pyright

if [ ! -d "$HOME/.config/nvim" ]; then
	mkdir -p "$HOME/.config/nvim"
	git clone "https://github.com/elianmanzueta/nvim"
fi

echo "Complete"
