#!/usr/bin/env zsh

# Install Rectangle for MacOS window management
# https://github.com/rxhanson/Rectangle

echo "=> Installing Rectangle"
brew ls --cask --versions rectangle || brew install --cask rectangle

defaults write com.knollsoft.Rectangle alternateDefaultShortcuts -bool true
defaults write com.knollsoft.Rectangle launchOnLogin -bool true
defaults write com.knollsoft.Rectangle subsequentExecutionMode -int 0
echo "=> Done installing Rectangle"
