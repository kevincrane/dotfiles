#!/usr/bin/env zsh

# Install Flux

echo "=> Installing and configuring Flux"
brew cask ls --versions flux || brew cask install flux

defaults write org.herf.Flux lateColorTemp -int 2700
defaults write org.herf.Flux nightColorTemp -int 3400
echo "=> Done installing Flux"
