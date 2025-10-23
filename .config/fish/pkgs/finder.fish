# my own implementation of well-known ff function
# uses rg to list files, fzf to select one and bat to preview

function ff --description "Search files in current dir"
  set -l file (rg --files --hidden --glob '!.git/*' . | fzf --preview "$_fzf_preview_command" --border --prompt="Find files > " "$_fzf_layout_window")

  if test -n "$file"
    $EDITOR $file
  end
end


function fg --description "Search files based on contents"
  set -l file (rg --files-with-matches "" .  --hidden --glob '!.git/*' | fzf --preview "$_fzf_preview_command" --border --prompt="Live grep > " "$_fzf_layout_window")

  if test -n "$file"
    $EDITOR $file
  end
end
