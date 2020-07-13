#!/usr/bin/env zsh

# This script links all of our dotfiles into place in the HOME directory;
# For each *.link file, it checks if it already exists in the destination
# and moves it to BACKUP_DIR if necessary, then symlinks itself in place.
#
# For MERGED_DIRS, we do the same process but use the same directory and
# file names in HOME as the desintation, letting us merge in side-by-side
# with other pre-existing files in bin/ or .config/


ROOT_DIR="$(cd "$(dirname "${0:a:h}")" ; pwd -P)"
BACKUP_DIR="$HOME/.cache/dotfiles_bak"

# The contents within these directories will be symlinked to their
# corresponding directory in HOME
MERGED_DIRS=(
  bin
  # .config
)

# Link all .link files as dotfiles in HOME; moves any existing files to backup
for dot_file in $ROOT_DIR/*.link; do
  filename=$(basename ${dot_file%.*})

  if [ -e $HOME/.${filename} ]; then
    if ! [ -L $HOME/.$filename ]; then
      mkdir -p $BACKUP_DIR
      # Move existing dotfile to $BACKUP_DIR
      mv $HOME/.$filename $BACKUP_DIR/.$filename
    else
      echo "=> Symlink already exists for .$filename"
      continue
    fi
  fi
  echo "=> Creating link for .${filename%.*}" # strips off .link extension
  ln -s $dot_file $HOME/.${filename%.*}
done

# For each merged directory, link its contents to the same dir in HOME, so the
# symlinks can comingle with other pre-existing contents
for merge_dir in $MERGED_DIRS; do
  for file in $ROOT_DIR/$merge_dir/*; do
    filename=$(basename $file)

    mkdir -p $HOME/$merge_dir
    if [ -e $HOME/$merge_dir/$filename ]; then
      if ! [ -L $HOME/${merge_dir}/$filename ]; then
        mkdir -p $BACKUP_DIR/$merge_dir
        # Move existing dotfile to $BACKUP_DIR
        mv $HOME/$merge_dir/$filename $BACKUP_DIR/$merge_dir/$filename
      else
        echo "=> $merge_dir/${filename} is already symlinked"
        continue
      fi
    fi
    echo "=> Creating link for $merge_dir/$filename"
    ln -s $ROOT_DIR/$merge_dir/$filename $HOME/$merge_dir/$filename
  done
done
