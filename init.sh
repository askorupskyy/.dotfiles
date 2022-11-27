#!/bin/zsh

# this is the init script for everything in this repo

# install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# add homebrew to path
echo '# Set PATH, MANPATH, etc., for Homebrew.' >> ~/.zprofile
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

# install all of the apps required 
brew bundle --file=~/.dotfiles/Brewfile

# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# install powerlevel10k theme
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# install nvm
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.2/install.sh | bash
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# install nvm, yarn, and global packages
eval nvm install --lts
eval npm install -g yarn
eval yarn install

source ~/.dotfiles/.zshrc

zsh ~/.dotfiles/scripts/lsp.sh
zsh ~/.dotfiles/scripts/links.sh
zsh ~/.dotfiles/scripts/fonts.sh
zsh ~/.dotfiles/scripts/tools.sh

# setup the iterm config
# specify the preferences directory
defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "~/.dotfiles/iterm_profile"
# tell iTerm2 to use the custom preferences in the directory
defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true
