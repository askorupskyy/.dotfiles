if status is-interactive
    # Commands to run in interactive sessions can go here
end

set pure_enable_single_line_prompt true
set pure_show_system_time true
set pure_show_system_time_pos 'right'

# set --universal nvm_default_version latest
set --universal nvm_default_packages yarn np

# git aliases
function git
    if test "$argv[1]" = "unstage"
        command git restore --staged $argv[2..-1]
    else
        command git $argv
    end
end


complete -c git -f -a "unstage" -d "Unstage changes"
complete -c git -n '__fish_seen_subcommand_from unstage' -a '(__fish_complete_path)'
