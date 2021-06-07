#!/usr/bin/env zsh

# Install Firefox

CURRENT_DIR="${0:a:h}"
FIREFOX_PROFILE=`ls -d ~/Library/Application\ Support/Firefox/Profiles/* | grep "default"`

echo "=> Installing and configuring Firefox"
brew ls --cask --versions firefox || brew install --cask firefox

# Install Firefox Proton UI Fix
# Firefox UI Improvements from: https://github.com/black7375/Firefox-UI-Fix/
echo "=> Copying userChrome files to $FIREFOX_PROFILE..."
cp -R -i ${CURRENT_DIR}/profile/* $FIREFOX_PROFILE

echo "=> Done installing Firefox"
