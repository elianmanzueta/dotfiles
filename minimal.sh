#!/bin/bash

CONFIG_DIR="~/config"
BASHRC="$CONFIG_DIR/files/.bashrc"
VIMRC="$CONFIG_DIR/files/.vimrc"

sudo apt-get update
sudo apt-get install curl

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
