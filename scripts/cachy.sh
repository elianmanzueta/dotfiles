#!/bin/bash

DIR="$HOME/dotfiles"

pacman -Syu

# Install paru
sudo pacman -S --needed base-devel
git clone https://aur.archlinux.org/paru.git
cd paru || exit
makepkg -si

# Symlinks
ln -fs "$DIR"/zsh/.zshrc "$HOME"/.zshrc
ln -fs "$DIR"/zsh/.p10k.zsh "$HOME"/.p10k.zsh

# Install packages
paru -S neovim ripgrep fd eza zoxide bat github-cli zsh curl kitty wl-clipboard steam stremio fzf bolt-launcher lutris git

# Pyenv-pyright
git clone https://github.com/alefpereira/pyenv-pyright.git "$(pyenv root)"/plugins/pyenv-pyright

# Clone neovim configuration
git clone "https://github.com/elianmanzueta/nvim" "$HOME"/.config/nvim
