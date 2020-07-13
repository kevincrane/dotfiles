#!/usr/bin/env zsh

# Works the opposite as in bootstrap.sh. For each .link file in this
# repo, we delete its corresponding symlink and replace the file with
# its backed up version if available.

ROOT_DIR="$(cd "$(dirname "${0:a:h}")" ; pwd -P)"
BACKUP_DIR="$HOME/.cache/dotfiles_bak"

MERGED_DIRS=(
  bin
  # .config
)


# Delete symlinks for merged directories and restore files from backup
for merge_dir in $MERGED_DIRS; do
  for file in $ROOT_DIR/$merge_dir/*; do
    filename=$(basename $file)

    if [ -L $HOME/$merge_dir/$filename ]; then
      echo "=> unlinking symlink $merge_dir/$filename"
      unlink $HOME/${merge_dir}/$filename
      # move backups back if applicable
      if [ -f $BACKUP_DIR/$merge_dir/$filename ]; then
        # Move existing dotfile to $BACKUP_DIR
        echo "=> restoring $merge_dir/$filename from backup"
        mv $BACKUP_DIR/$merge_dir/$filename $HOME/$merge_dir/$filename
        rmdir $BACKUP_DIR/$merge_dir 2> /dev/null
      fi
    fi
  done
  rmdir $HOME/$merge_dir 2> /dev/null
done

# Delete all relevant symlinks in the HOME directory and restore files from backup
echo "$ROOT_DIR/*.link"
for dot_file in $ROOT_DIR/*.link; do
  filename=$(basename ${dot_file%.*})

  echo $filename
  if [ -L $HOME/.$filename ]; then
    echo "=> unlinking symlink .$filename"
    unlink $HOME/.$filename
    # move backups back if applicable
    if [ -f $BACKUP_DIR/.$filename ]; then
      # Move existing dotfile to $BACKUP_DIR
      echo "=> restoring .$filename from backup"
      mv $BACKUP_DIR/.$filename $HOME/.$filename
    fi
  fi
done

# Delete backup cache folder if we've emptied it out
rmdir $BACKUP_DIR 2> /dev/null
