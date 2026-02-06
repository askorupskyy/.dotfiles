if status is-interactive
    # Commands to run in interactive sessions can go here
end

function fish_user_key_bindings
    bind \cc 'commandline ""'
end

# disable automatic brew updates
set HOMEBREW_NO_AUTO_UPDATE 1

# pyenv
set -Ux PYENV_ROOT $HOME/.pyenv
set -U fish_user_paths $PYENV_ROOT/bin $fish_user_paths

# shell font-friendly git symbols
set pure_symbol_git_unpushed_commits ""
set pure_symbol_git_unpulled_commits ""

# settings for shell
set pure_enable_single_line_prompt true
set pure_show_system_time true
set pure_show_system_time_pos right

# set vscode as the default editor
set -gx EDITOR code

# load my own plugins
source ~/.dotfiles/.config/fish/pkgs/finder.fish
