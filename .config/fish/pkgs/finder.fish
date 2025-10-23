# my own implementation of well-known ff, fg, and gb functions
# uses rg to list files, fzf to select one and bat to preview

function ff --description "Search files in current dir"
  set -l file (rg --files --hidden --glob '!.git/*' . | fzf --preview "$_fzf_preview_command" --border --prompt="Find files > " "$_fzf_layout_window")

  if test -n "$file"
    $EDITOR $file
  end

  print "No file selected"
end


function fg --description "Search files based on contents"
  set -l file (rg --files-with-matches "" .  --hidden --glob '!.git/*' | fzf --preview "$_fzf_preview_command" --border --prompt="Live grep > " "$_fzf_layout_window")

  if test -n "$file"
    $EDITOR $file
  end

  print "No file selected"
end

function gb --description "Search git branches"
  set -l branch (git branch --all --color=never | sed 's/^[* ]*//' | fzf --preview "git log -n 10 --pretty=format:'%C(yellow)%h %C(cyan)%ad %C(green)%an%Creset %s' {1}" --border --prompt="Git branches > " "$_fzf_layout_window")

  if test -n "$branch"
    git checkout (string trim (string replace 'remotes/origin/' '' $branch))
  end

  print "No branch selected"
end
