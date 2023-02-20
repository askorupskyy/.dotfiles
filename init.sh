#!/bin/zsh

# this is the init script for everything in this repo

# install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# set brew path here
brew_path="$(which brew)"

# add homebrew to path
echo '# Set PATH, MANPATH, etc., for Homebrew.' >> ~/.zprofile
eval "$brew_path shellenv" >> ~/.zprofile

# install all of the apps required 
brew bundle --file=~/.dotfiles/Brewfile

# assign fish path to variable
fish_path="$(which fish)"

# set fish as the default shell
sudo bash -c "echo $fish_path >> /etc/shells"
sudo chsh -s $fish_path

# install fisher
$fish_path -c "curl -sL https://git.io/fisher | source & fisher install jorgebucaran/fisher"

# add brew to fish path
$fish_path -c "fish_add_path $brew_path"

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
/bin/zsh ~/.dotfiles/scripts/fonts.sh
/bin/zsh ~/.dotfiles/scripts/tools.sh

# setup the iterm config
# specify the preferences directory
defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "~/.dotfiles/iterm_profile"
# tell iTerm2 to use the custom preferences in the directory
defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true
