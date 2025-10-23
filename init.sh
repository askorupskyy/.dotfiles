#!/bin/zsh

# this is the init script for everything in this repo

# this will get the homebrew instalation path:
# copied from homebrew installer: https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh
OS="$(uname)"

if [ "$OS" = "Darwin" ]; then
  UNAME_MACHINE="$(/usr/bin/uname -m)"
  if [ "$UNAME_MACHINE" = "arm64" ]; then
    HOMEBREW_PREFIX="/opt/homebrew"
  else
    HOMEBREW_PREFIX="/usr/local"
  fi
elif [ "$OS" = "Linux" ]; then
  HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew"
else
  abort "Homebrew is only supported on macOS and Linux."
fi

# install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# set brew path here
brew_path=$HOMEBREW_PREFIX/bin

# add homebrew to path
eval "$($brew_path/brew shellenv)"

source ~/.zshrc

# install all of the apps required
$brew_path/brew bundle --file=~/.dotfiles/Brewfile

# assign fish path to variable
fish_path="$(which fish)"

# set fish as the default shell
sudo bash -c "echo $fish_path >> /etc/shells"
sudo chsh -s $fish_path

# install fisher
$fish_path -c "curl -sL https://git.io/fisher | source & fisher install jorgebucaran/fisher"

# add brew to fish path
$fish_path -c "fish_add_path $brew_path/bin"

# install fish plugins
$fish_path -c "fisher update"

# install nvm, yarn, and global packages
$fish_path -c "nvm install latest"
$fish_path -c "nvm use latest"

/bin/zsh ~/.dotfiles/scripts/links.sh
/bin/zsh ~/.dotfiles/scripts/tools.sh

# terminate the script if the OS is not mac
if [ "$OS" = "Linux" ]; then
  exit 0
fi

# width for icons in menu bar
defaults -currentHost write -globalDomain NSStatusItemSpacing -int 10
defaults -currentHost write -globalDomain NSStatusItemSelectionPadding -int 16

# disable press and hold for keys in vscode
defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false
# install vscode extensions
xargs -n1 code --install-extension < ~/.dotfiles/vscode/extensions.txt
