#!/usr/bin/env zsh

# Install Sublime Text 3
# Note for Kevin: you have a Sublime 3 license in Dropbox

CURRENT_DIR="${0:a:h}"
SUBLIME_SETTINGS_DIR="$HOME/Library/Application Support/Sublime Text 3/Packages/User"

echo "=> Installing Sublime Text 3"
brew cask ls --versions sublime-text || brew cask install sublime-text

echo "=> Killing any running Sublime processes"
pkill "Sublime Text"
sleep 2

# Link our Sublime configs to the Sublime Application Support directory
for source_file in $CURRENT_DIR/settings/*; do
  dest_file="$SUBLIME_SETTINGS_DIR/$(basename $source_file)"
  echo "=> Linking Sublime config to $source_file"
  rm -f $dest_file
  ln -s $source_file $dest_file
done

echo "=> Done installing Sublime Text 3"
