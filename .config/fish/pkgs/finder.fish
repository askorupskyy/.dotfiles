# my own implementation of well-known ff, fg, and gb functions
# uses rg to list files, fzf to select one and bat to preview

set _rg_options --hidden -S --glob '!.git/*'
set _fzf_layout_window '--preview-window=top:50%'

function ff --description "Search files in current dir"
  set -l command ""     # default editor filled later unless other command given
  set -l root "."       # default search directory - default current dir
  set -l killAfter 0    # kill fzf when editor exits - default false

  # TODO: make this a separate function later
  while test (count $argv) -gt 0
    switch $argv[1]
      case --command
        set command $argv[2]
        set argv $argv[3..-1]
      case --root
        set root $argv[2]
        set argv $argv[3..-1]
      case --kill-after
        set killAfter 1
        set argv $argv[2..-1]
    end
  end

  # Default to $EDITOR
  if test -z "$command"
    set command $EDITOR
  end

  set _fzf_preview_command 'bat --style=numbers --color=always --line-range :500 {}'
  set -l file (
    rg $_rg_options --files $root \
    | fzf -m --ansi --preview "$_fzf_preview_command" --border --prompt="Find files > " "$_fzf_layout_window"
  )

  if test -n "$file"
    $command $file
  else
    echo "No file selected"
  end

  if test $killAfter -eq 1
    exit;
  end
end


function fg --description "Search files based on contents"
  set killAfter 0    # exit terminal fzf exits - default false

  switch $argv[1]
    case --kill-after
      set killAfter 1
      set argv $argv[2..-1]
  end

  set _fzf_preview_command 'bat --style=header,numbers --color=always -r {2}::15 --highlight-line {2} {1}'
  set -l file (
    rg $_rg_options  --line-number --no-heading "" \
    | fzf -m --ansi --delimiter=: --preview "$_fzf_preview_command" --border --prompt="Live grep > " "$_fzf_layout_window" \
    | awk -F: '{print $1":"$2}'
  )

  echo $file

  if test -n "$file"; and test $EDITOR = "code"
    $EDITOR -g $file
  else if test -n "$file"
    $EDITOR $file
  else
    echo "No file selected"
  end

  if test $killAfter -eq 1
    exit;
  end
end

function gb --description "Search git branches"
  set -l branch (git branch --all --color=never | sed 's/^[* ]*//' | fzf --ansi --preview "git log -n 10 --pretty=format:'%C(yellow)%h %C(cyan)%ad %C(green)%an%Creset %s' {1}" --border --prompt="Git branches > " "$_fzf_layout_window")

  if test -n "$branch"
    git checkout (string trim (string replace 'remotes/origin/' '' $branch))
  else
    echo "No branch selected"
  end
end

function gs --description "Search git status files"
  set -l file (git status --porcelain | awk '{print $2}' | fzf --ansi --preview "git diff --color=always -- {1} | bat --style=numbers --color=always --paging=never -l diff -" --border --prompt="Git status > " "$_fzf_layout_window")

  if test -n "$file"
    $EDITOR $file
  else
    echo "No file selected"
  end
end
