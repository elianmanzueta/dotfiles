#!/bin/bash

# Variables
DIR=$PWD
OS=$(uname -s)

# Install packages
if [ "$OS" = "Linux" ]; then
	sudo apt-get install curl zsh git
fi

# Install Oh My Zsh!
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

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
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

case "$OS" in
Darwin)
	export PATH="/opt/homebrew/bin:$PATH"
	;;
Linux)
  export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
  ;;
esac

# Install brew packages
brew install gh
brew install neovim
brew install tree
brew install ripgrep
brew install lazygit
brew install tmux
brew install pyenv
brew install pyenv-virtualenv

# Install pyenv pyright
git clone https://github.com/alefpereira/pyenv-pyright.git $(pyenv root)/plugins/pyenv-pyright

# Neovim config
if [ ! -d "$HOME/.config/" ]; then
	mkdir -p "$HOME/.config/"
fi

git clone "https://github.com/elianmanzueta/nvim" $HOME/.config/nvim

echo "Complete"
