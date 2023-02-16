#!/bin/zsh

# this is the init script for everything in this repo

# install Homebrew
/bin/zsh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# add homebrew to path
echo '# Set PATH, MANPATH, etc., for Homebrew.' >> ~/.zprofile
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

# install all of the apps required 
brew bundle --file=~/.dotfiles/Brewfile

# add homebrew to fish path
echo '# Set PATH, MANPATH, etc., for Homebrew.' >> ~/.config/fish/config.fish
echo 'eval (/opt/homebrew/bin/brew shellenv)' >> ~/.config/fish/config.fish
/opt/homebrew/bin/fish -c 'eval "$(/opt/homebrew/bin/brew shellenv)"'

# set fish as the default shell
sudo bash -c 'echo $(which fish) >> /etc/shells'
chsh -s $(which fish)

# install fisher
curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
# install fish plugins
/opt/homebrew/bin/fish -c "fisher update"

# install nvm, yarn, and global packages
/opt/homebrew/bin/fish -c nvm install latest
# install node 16.16.0 for copilot to work on apple sillicon
/opt/homebrew/bin/fish -c nvm install 16.16.0
/opt/homebrew/bin/fish -c nvm use latest
/opt/homebrew/bin/fish -c npm install -g yarn
/opt/homebrew/bin/fish -c npm install -g pnpm
/opt/homebrew/bin/fish -c yarn install

/bin/zsh ~/.dotfiles/scripts/lsp.sh
/bin/zsh ~/.dotfiles/scripts/links.sh
/bin/zsh ~/.dotfiles/scripts/fonts.sh
/bin/zsh ~/.dotfiles/scripts/tools.sh

# setup the iterm config
# specify the preferences directory
defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "~/.dotfiles/iterm_profile"
# tell iTerm2 to use the custom preferences in the directory
defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true
