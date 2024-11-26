if status is-interactive
    # Commands to run in interactive sessions can go here
end

set pure_enable_single_line_prompt true
set pure_show_system_time true
set pure_show_system_time_pos right

# set --universal nvm_default_version latest
set --universal nvm_default_packages yarn np

function git
    if test "$argv[1]" = unstage
        command git restore --staged $argv[2..-1]
    else
        command git $argv
    end
end


complete -c git -f -a unstage -d "Unstage changes"
complete -c git -n '__fish_seen_subcommand_from unstage' -a '(__fish_complete_path)'

function fish_user_key_bindings
    bind \cc 'commandline ""'
end

# pnpm
set -gx PNPM_HOME /Users/bamboolio/Library/pnpm
set -gx PATH "$PNPM_HOME" $PATH
# pnpm end
# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

# disable automatic brew updates
set HOMEBREW_NO_AUTO_UPDATE 1

pyenv init - | source

# Created by `pipx` on 2024-10-09 19:33:36
set PATH $PATH /Users/bamboolio/.local/bin

# Created by `pipx` on 2024-11-05 22:45:54
set PATH $PATH /Users/askorupskyy/.local/bin
