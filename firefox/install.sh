#!/usr/bin/env zsh

# Install Firefox

CURRENT_DIR="${0:a:h}"
FIREFOX_PROFILE=`ls -d ~/Library/Application\ Support/Firefox/Profiles/* | grep "default"`

echo "=> Installing and configuring Firefox"
brew ls --cask --versions firefox || brew install --cask firefox

# Install Firefox Proton UI Fix
# Firefox UI Improvements from: https://github.com/black7375/Firefox-UI-Fix/
echo "=> Copying userChrome files to $FIREFOX_PROFILE..."

ln -f ${CURRENT_DIR}/profile/user.js $FIREFOX_PROFILE/user.js
mkdir -p ${FIREFOX_PROFILE}/chrome
ln -f ${CURRENT_DIR}/profile/chrome/userChrome.css $FIREFOX_PROFILE/chrome/userChrome.css
ln -f ${CURRENT_DIR}/profile/chrome/userContent.css $FIREFOX_PROFILE/chrome/userContent.css
mkdir -p ${FIREFOX_PROFILE}/chrome/icons
ln -f ${CURRENT_DIR}/profile/chrome/icons/tab-bottom-corner.svg $FIREFOX_PROFILE/chrome/icons/tab-bottom-corner.svg

echo "=> Done installing Firefox"
