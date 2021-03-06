#!/usr/bin/env bash
#
# Usage: ./bootstrap.sh
# This script does the following:
# - setup gitconfig
# - link all *.link files to $HOME
# - run `dot`, which updates and runs all homebrew and install.sh scripts

cd "$(dirname "$0")/.."
DOTFILES_ROOT=$(pwd -P)

set -e

echo ''

# Pretty-print log messages
info () {
  printf "\r  [ \033[00;34m..\033[0m ] $1\n"
}
user () {
  printf "\r  [ \033[0;33m??\033[0m ] $1\n"
}

success () {
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

fail () {
  printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"
  echo ''
  exit
}

# Your git config might be different on each machine (e.g. work/personal); this creates a new ~/.gitconfig.local
setup_gitconfig () {
  if ! [ -f git/gitconfig.local.link ]
  then
    info '=> setting up gitconfig.local'

    git_credential='cache'
    if [ "$(uname -s)" == "Darwin" ]
    then
      git_credential='osxkeychain'
    fi

    user ' - What is your github author name?'
    read -e git_authorname
    user ' - What is your github author email?'
    read -e git_authoremail

    sed -e "s/AUTHORNAME/$git_authorname/g" -e "s/AUTHOREMAIL/$git_authoremail/g" -e "s/GIT_CREDENTIAL_HELPER/$git_credential/g" git/gitconfig.local.link.example > git/gitconfig.local.link

    success 'gitconfig'
  fi
}


# Symlink *.link files to the $HOME directory
link_file () {
  local src=$1 dst=$2

  local overwrite= backup= skip=
  local action=

  # Check if a file/dir/link already exists for this file
  if [ -f "$dst" -o -d "$dst" -o -L "$dst" ]
  then

    if [ "$overwrite_all" == "false" ] && [ "$backup_all" == "false" ] && [ "$skip_all" == "false" ]
    then

      local currentSrc="$(readlink $dst)"
      if [ "$currentSrc" == "$src" ]
      then
        # matching symlink already exists for this file
        skip=true;
      else
        user "File already exists: $dst ($(basename "$src")), what do you want to do?\n\
        [s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all?"
        read -n 1 action

        case "$action" in
          o )
            overwrite=true;;
          O )
            overwrite_all=true;;
          b )
            backup=true;;
          B )
            backup_all=true;;
          s )
            skip=true;;
          S )
            skip_all=true;;
          * )
            ;;
        esac
      fi
    fi

    overwrite=${overwrite:-$overwrite_all}
    backup=${backup:-$backup_all}
    skip=${skip:-$skip_all}

    if [ "$overwrite" == "true" ]
    then
      rm -rf "$dst"
      success "removed $dst"
    fi

    if [ "$backup" == "true" ]
    then
      mv "$dst" "${dst}.backup"
      success "moved $dst to ${dst}.backup"
    fi

    if [ "$skip" == "true" ]
    then
      success "skipped $src"
    fi
  fi

  if [ "$skip" != "true" ]  # "false" or empty
  then
    ln -s "$1" "$2"
    success "linked $1 to $2"
  fi
}

install_dotfiles () {
  info "linking dotfiles (*.link) from $DOTFILES_ROOT"

  local overwrite_all=false backup_all=false skip_all=false

  for src in $(find -H "$DOTFILES_ROOT" -maxdepth 2 -name '*.link' -not -path '*.git*')
  do
    dst="$HOME/.$(basename "${src%.*}")"
    link_file "$src" "$dst"
  done
}


##### bootstrap.sh starts running from here #####

# Setup .gitconfig.local
setup_gitconfig

# Link all dotfiles to $HOME
install_dotfiles

# If we're on a Mac, let's install and setup homebrew.
if [ "$(uname -s)" == "Darwin" ]
then
  info "installing dependencies with dot"
  if source bin/dot | while read -r data; do info "$data"; done
  then
    success "dependencies installed"
  else
    fail "error installing dependencies"
  fi
fi

echo ''
echo '  All installed!'
