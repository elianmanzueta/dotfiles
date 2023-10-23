CONFIG_DIR="$HOME/dotfiles"
ZSHRC="$CONFIG_DIR/.zsh/.zshrc"
ZSH_THEME="$CONFIG_DIR/.zsh/themes"
BASHRC="$CONFID_DIR/.bashrc"
NVIM="$HOME/.config/nvim"

if [ "$OSTYPE" = "linux-gnu" ]; then
	sudo apt-get update
	sudo apt-get upgrade
	sudo apt-get install curl
fi

# Install Oh My Zsh!
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install P10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# Instll ZSH Plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions             # Autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting # Syntax Highlighting

# Clone neovim repo
echo "\nCloning neovim repository..."
mkdir $HOME/.config/nvim
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

# Prompt user for confirmation
read -p "Install Homebrew? (y\n) " confirmation

if [[ "$confirmation" == [yY]* ]]; then
	# Install Homebrew
	echo "\nInstalling Homebrew..."
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
	# Installing stuff
	brew install neovim
	brew install aichat
	if [ "$OSTYPE" = "darwin"* ]; then
		brew install zsh
		brew install curl
		brew install xclip
		brew install tmux
	fi
else
	echo "Homebrew installation aborted."
fi

if [ "$OSTYPE" = "linux-gnu" ]; then
	sudo apt-get install wget snmp snmpd snmp-mibs-downloader fail2ban cmatrix unzip libfuse2 ninja-build gettext cmake zsh xclip

fi

# Add ZSH to /etc/shells
echo "\nAdding ZSH to allowed shells..."
command -v zsh | sudo tee -a /etc/shells

echo "Run chsh to change shell to ZSH"

echo "Complete."
