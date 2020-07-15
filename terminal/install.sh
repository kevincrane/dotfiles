#!/usr/bin/env zsh

# Install default Mac Terminal.app profile

echo "=> Installing Terminal.app configuration"
open ${0:a:h}/Dracula.terminal   # opens a new terminal window, but you can close it safely
defaults write com.apple.Terminal "Default Window Settings" "Dracula"
defaults write com.apple.Terminal "Startup Window Settings" "Dracula"
echo "=> Done installing Terminal.app
"