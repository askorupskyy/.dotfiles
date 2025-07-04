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
brew_path=$HOMEhomebrewBREW_PREFIX/bin

echo $brew_path

# add homebrew to path
(echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> ~/.dotfiles/.zshrc
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
# install node 16.16.0 for copilot to work on apple sillicon
$fish_path -c "nvm install 16.16.0"
$fish_path -c "nvm use latest"
sudo $fish_path -c "nvm use latest & npm install -g yarn pnpm"
$fish_path -c "nvm use latest & yarn install"

/bin/zsh ~/.dotfiles/scripts/lsp.sh
/bin/zsh ~/.dotfiles/scripts/links.sh
/bin/zsh ~/.dotfiles/scripts/tools.sh

# terminate the script if the OS is not mac
if [ "$OS" = "Linux" ]; then
  exit 1
fi

# width for icons in menu bar
defaults -currentHost write -globalDomain NSStatusItemSpacing -int 10
defaults -currentHost write -globalDomain NSStatusItemSelectionPadding -int 16
