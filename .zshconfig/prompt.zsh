# Kevin's ZSH theme
# [DATE TIME] path/from/root/or/git (branch *) %

autoload -U colors && colors
setopt prompt_subst         # Reevaluate prompt on each line

# Prints either the full path from root/home, or the path from .git root
function get_pwd(){
  git_root=$PWD
  while [[ $git_root != / && ! -e $git_root/.git ]]; do
    git_root=$git_root:h
  done
  if [[ $git_root = / ]]; then
    unset git_root
    prompt_short_dir=%~
  else
    parent=${git_root%\/*}
    prompt_short_dir=${PWD#$parent/}
  fi
  echo $prompt_short_dir
}

function date_and_time() {
  # Uses time strfmt (%D and %T in this case)
  echo "%{$fg[blue]%}%D{[%D %T]}%{$reset_color%}"
}

# Prints the name of the current git branch
if (( $+commands[git] ))
then
  git="$commands[git]"
else
  git="/usr/bin/git"
fi

function git_dirty() {
  if [[ $($git status -uno --porcelain) == "" ]]
  then
    echo ""
  else
    echo "%{$fg_bold[red]%} *%{$fg[green]%}"
  fi
}

function git_prompt_info() {
  if $(! $git status -s &> /dev/null)
  then
    echo ""
  else
    ref=$($git symbolic-ref HEAD 2>/dev/null) || return
    echo "%{$fg[green]%}(${ref#refs/heads/}$(git_dirty))%{$reset_color%} "
  fi
}

# Define the ZSH prompt
export PROMPT='$(date_and_time) %{$fg[white]%}$(get_pwd)%{$reset_color%} $(git_prompt_info)%#%{$reset_color%} '
