#!/usr/bin/env zsh

# Install karabiner-elements for Mac key remapping
# https://karabiner-elements.pqrs.org/

CURRENT_DIR="${0:a:h}"
KARABINER_CONFIG="$HOME/.config/karabiner/karabiner.json"

echo "=> Installing karabiner-elements"
brew cask ls --versions karabiner-elements || brew cask install karabiner-elements

echo "=> Linking karabiner configs to $KARABINER_CONFIG"
rm -f $KARABINER_CONFIG
ln -s $CURRENT_DIR/karabiner.json $KARABINER_CONFIG

echo "=> Done installing karabiner-elements"
