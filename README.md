# .dotfiles

## Description

Contains all my work machine configurations. I maintain this repository for own purposes, including the installer, which is used to replicate the environment for each new machine I get.

### Stack - As simple as can be

- Editor(s): VSCode, nvim (legacy)
- Terminal: Ghostty (rarely used tbh)
- Font: Meslo LG Nerd Font

### Code Editor

I use VSCode as my main editor at the moment. It works just like nvim with a few more useful keybinds:

- `<leader>ff` - find files.
- `<leader>fg` - live grep.
- `<leader>sa` - surround. my own plugin.
- `<cmd-c>` - toggle chat.
- `<leader>cas` - add selection to chat.
- `<cmd-t>` - toggle terminal.
- `<c-w>` - kill terminal.
- `<leader>tt` - open todo list.

## Installation

1. `xcode-select --install`
2. `cd ~`
3. `git clone https://github.com/askorupskyy/.dotfiles.git`
4. `cd .dotfiles`
5. `./init.sh`
