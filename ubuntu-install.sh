#!/bin/bash

# Vars
DIR="$HOME/dotfiles"

# Ubuntu
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install curl zsh fzf gh

## Symlinks
ln -fs "$DIR"/.zshrc-ubuntu "$HOME"/.zshrc
ln -fs "$DIR"/.p10k.zsh "$HOME"/.p10k.zsh
ln -fs "$DIR"/.gitconfig "$HOME"/.gitconfig
ln -fs "$DIR"/.tmux.conf "$HOME"/.tmux.conf

## Install Oh My Zsh + Plugins
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

### P10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"/themes/powerlevel10k

### Zsh Syntax Highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"/plugins/zsh-syntax-highlighting

### Zsh Autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"/plugins/zsh-autosuggestions

# Python
sudo apt-get install python3.12-venv

## Python Build Tools
sudo apt install build-essential libssl-dev zlib1g-dev \
  libbz2-dev libreadline-dev libsqlite3-dev curl git \
  libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev

## Install Pyenv + Plugins
curl https://pyenv.run | bash

### Pyenv-virtualenv
git clone https://github.com/pyenv/pyenv-virtualenv.git "$(pyenv root)"/plugins/pyenv-virtualenv

### Pyenv-pyright
git clone https://github.com/alefpereira/pyenv-pyright.git "$(pyenv root)"/plugins/pyenv-pyright

# Neovim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
sudo mkdir -p /opt/nvim
sudo mv nvim.appimage /opt/nvim/nvim

## Neovim Configuration
if [ ! -d "$HOME/.config" ]; then
  mkdir -p "$HOME/.config/"
fi

git clone "https://github.com/elianmanzueta/nvim" "$HOME/.config/nvim"

## Unzip
sudo apt-get install unzip

## Fd
sudo apt-get install fd-find

## Lazygit
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin

# Unattended Upgrades
sudo apt-get install unattended-upgrades -y
sudo dpkg-reconfigure -plow unattended-upgrades
