# Install Rectangle for MacOS window management
# https://github.com/rxhanson/Rectangle

brew cask install rectangle

defaults write com.knollsoft.Rectangle alternateDefaultShortcuts -bool true
defaults write com.knollsoft.Rectangle launchOnLogin -bool true
defaults write com.knollsoft.Rectangle subsequentExecutionMode -int 0
