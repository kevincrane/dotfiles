#!/usr/bin/env zsh

# Install Firefox

FIREFOX_PROFILE=`ls -d ~/Library/Application\ Support/Firefox/Profiles/* | grep "default"`

echo "=> Installing and configuring Firefox"
brew ls --cask --versions firefox || brew install --cask firefox

# Install Firefox Proton UI Fix
wget -q -O firefox-proton-ui.zip https://github.com/black7375/Firefox-UI-Fix/archive/refs/heads/master.zip
unzip -q firefox-proton-ui.zip
cp -n Firefox-UI-Fix-master/user.js $FIREFOX_PROFILE
mkdir -p ${FIREFOX_PROFILE}/chrome
cp -n Firefox-UI-Fix-master/userChrome.css ${FIREFOX_PROFILE}/chrome
cp -n Firefox-UI-Fix-master/userContent.css ${FIREFOX_PROFILE}/chrome
cp -n -R Firefox-UI-Fix-master/icons ${FIREFOX_PROFILE}/chrome
rm -rf Firefox-UI-Fix-master
rm firefox-proton-ui.zip

echo "=> Done installing Firefox"
