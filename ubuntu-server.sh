CONFIG_DIR="$HOME/dotfiles"
ZSHRC="$CONFIG_DIR/.zsh/.zshrc"
ZSH_THEME="$CONFIG_DIR/.zsh/themes"
BASHRC="$CONFIG_DIR/.bashrc"
P10K="$CONFIG_DIR/.zsh/.p10k.zsh"
NEOVIM="$HOME/.config/nvim"

if [ "$OSTYPE" = "linux-gnu" ]; then
	sudo apt-get update
	sudo apt-get upgrade
	sudo apt-get install curl
fi

# Oh My Zsh!
if [ ! -d "$HOME/.oh-my-zsh" ]; then
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# P10K
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]; then
	git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
fi

# Plugins
if [ ! -d "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ]; then
	git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi
if [ ! -d "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" ]; then
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
fi

# Neovim
echo "\nCloning neovim repository..."
if [ ! -d "$NEOVIM" ]; then
	mkdir -p $NEOVIM
	git clone https://github.com/elianmanzueta/nvim $NEOVIM
fi

# Symlinks
echo "\nConfiguring symlinks..."
ln -fs $ZSHRC $HOME/.zshrc
ln -fs $BASHRC $HOME/.bashrc
ln -fs $P10K $HOME/.p10k.zsh

# Gitconfig
echo "\nConfiguring gitconfig..."
git config --global user.name "Elian Manzueta"
git config --global user.email "eliandmanzueta@gmail.com"
git config --global color.ui auto

# Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
brew install neovim
brew install gh

# Packages
sudo apt-get install wget snmp snmpd snmp-mibs-downloader fail2ban cmatrix unzip libfuse2 ninja-build gettext cmake zsh xclip

# ZSH
command -v zsh | sudo tee -a /etc/shells
echo "Run chsh to change shell to ZSH."
