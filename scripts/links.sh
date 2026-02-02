#!/bin/zsh

# this script is designed to create the symantic links for all of the configs in this dotfiles repo

# create the symantic links for the configs
ln -sf ~/.dotfiles/.zshrc ~/.zshrc
ln -sf ~/.dotfiles/.vimrc ~/.vimrc
ln -sf ~/.dotfiles/.vim ~/.vim
ln -sf ~/.dotfiles/.gitconfig ~/.gitconfig
ln -sf ~/.dotfiles/.nvimrc ~/.nvimrc
// needs to be recursive for all subfolders and files in the .config directory
ln -sf ~/.dotfiles/.config ~/.config
ln -sf ~/.dotfiles/.config/nvim ~/.config/nvim
ln -sf ~/.dotfiles/.config/fish/config.fish ~/.config/fish/config.fish
ln -sf ~/.dotfiles/.p10k.zsh ~/.p10k.zsh

# sync vscode settings
ln -sf ~/.dotfiles/vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json
ln -sf ~/.dotfiles/vscode/keybindings.json ~/Library/Application\ Support/Code/User/keybindings.json
