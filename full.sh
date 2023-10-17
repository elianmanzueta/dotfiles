CONFIG_DIR="$HOME/dotfiles"
ZSHRC="$CONFIG_DIR/.zsh/.zshrc"
ZSH_THEME="$CONFIG_DIR/.zsh/themes"
BASHRC="$CONFID_DIR/.bashrc"

if [ "$OSTYPE" = "linux-gnu" ]; then
	sudo apt-get update
	sudo apt-get upgrade
	sudo apt-get install curl
fi

# Install Oh My Zsh!
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Create symbolic link for Headline Oh My Zsh! Theme
ln -s $ZSH_THEME/headline.zsh-theme ~/.oh-my-zsh/custom/themes/headline.zsh-theme

# Instll ZSH Plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions             # Autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting # Syntax Highlighting

# Clone neovim repo
echo "\nCloning neovim repository..."
mkdir $HOME/.config/.nvim
git clone https://github.com/elianmanzueta/nvim $NVIM

# Configure symlinks
echo "\nConfiguring symlinks..."
ln -fs $ZSHRC $HOME/.zshrc
ln -fs $BASHRC $HOME/.bashrc

# Configure gitconfig
echo "\nConfiguring gitconfig..."
git config --global user.name "Elian Manzueta"
git config --global user.email "eliandmanzueta@gmail.com"
git config --global color.ui auto

# Install Homebrew
echo "\nInstalling Homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# Installing stuff
echo "\nInstalling packages..."
brew install neovim
brew install aichat

if [ "$OSTYPE" = "linux-gnu" ]; then
	sudo apt-get install wget snmp snmpd snmp-mibs-downloader fail2ban cmatrix unzip libfuse2 ninja-build gettext cmake zsh xclip
elif [ "$OSTYPE" = "darwin"* ]; then
	brew install zsh
	brew install curl
	brew install xclip
	brew install tmux
fi

# Add ZSH to /etc/shells
echo "\nAdding ZSH to allowed shells..."
command -v zsh | sudo tee -a /etc/shells

echo "Run chsh to change shell to ZSH"
