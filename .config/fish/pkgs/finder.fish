# my own implementation of well-known ff, fg, and gb functions
# uses rg to list files, fzf to select one and bat to preview

set _rg_options --hidden -S --glob '!.git/*'
set _fzf_layout_window '--preview-window=top:50%'

function ff --description "Search files in current dir"
  set _fzf_preview_command 'bat --style=numbers --color=always --line-range :500 {}'
  set -l file (rg $_rg_options --files . | fzf --ansi --preview "$_fzf_preview_command" --border --prompt="Find files > " "$_fzf_layout_window")

  if test -n "$file"
    $EDITOR $file
  end

  echo "No file selected"
end


function fg --description "Search files based on contents"
  set _fzf_preview_command 'bat --style=numbers --color=always --highlight-line {2} {1}'
  set -l file (
    rg $_rg_options  --line-number --no-heading "" \
    | fzf --ansi --delimiter=: --preview "$_fzf_preview_command" --border --prompt="Live grep > " "$_fzf_layout_window" \
    | awk -F: '{print $1":"$2}'
  )

  echo $file

  if test -n "$file"; and test $EDITOR = "code"
    $EDITOR -g $file
  else if test -n "$file"
    $EDITOR $file
  end

  echo "No file selected"
end

function gb --description "Search git branches"
  set -l branch (git branch --all --color=never | sed 's/^[* ]*//' | fzf --ansi --preview "git log -n 10 --pretty=format:'%C(yellow)%h %C(cyan)%ad %C(green)%an%Creset %s' {1}" --border --prompt="Git branches > " "$_fzf_layout_window")

  if test -n "$branch"
    git checkout (string trim (string replace 'remotes/origin/' '' $branch))
  end

  echo "No branch selected"
end
