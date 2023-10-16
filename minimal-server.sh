#!/bin/bash

CONFIG_DIR="~/dotfiles"
ZSHRC="$CONFIG_DIR/.zsh/.zshrc"
ZSH_THEME="$CONFIG_DIR/.zsh/themes"
BASHRC="$CONFIG_DIR/.bashrc"
VIMRC="$CONFIG_DIR/.vimrc"

# Pregame
sudo apt-get update
sudo apt-get install curl zsh fail2ban wget

# Security stuff
sudo apt-get install fail2ban
sudo systemctl enable fail2ban
sudo ufw allow ssh
sudo ufw enable
sudo echo "DisableForwarding yes" >>/etc/ssh/sshd_config.d/10-my-sshd-settings.conf

# Configure symlinks
echo "\nConfiguring symlinks..."
ln -fs $BASHRC $HOME/.bashrc
ln -fs $VIMRC $HOME/.vimrc

# Install Oh My Zsh!
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Create symbolic link for Headline Oh My Zsh! Theme
ln -s $ZSH_THEME/headline.zsh-theme ~/.oh-my-zsh/custom/themes/headline.zsh-theme

# Add ZSH to /etc/shells
echo "\nAdding ZSH to allowed shells..."
command -v zsh | sudo tee -a /etc/shells

echo "Run chsh to change shell to ZSH."
