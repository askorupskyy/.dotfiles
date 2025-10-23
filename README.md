# .dotfiles

## Description

Contains all my work machine configurations. I maintain this repository for own purposes, including the installer, which is used to replicate the environment for each new machine I get.

The nvim config included in this repo was made by @pedropmedina. The version included here is slightly modified.

### Code Editor

I use VSCode as my main editor at the moment. It works just like nvim:

- `<leader>ff` - find files.
- `<leader>fg` - live grep.
- `sa` - surround.
- `<cmd-t>` - enable terminal.
- `<c-t>` - new terminal.
- `<leader>tt` - open todo list.

## Installation

1. `xcode-select --install`
2. `cd ~`
3. `git clone https://github.com/rcbxd/.dotfiles.git`
4. `cd .dotfiles`
5. `./init.sh`
