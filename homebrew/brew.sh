#!/usr/bin/env zsh

# Install command-line tools using Homebrew.
brew update                       # Make sure we’re using the latest Homebrew.
# Upgrade any already-installed formulae.
brew upgrade

# Save Homebrew’s installed location.
BREW_PREFIX=$(brew --prefix)
DOTFILE_REPO=${0:a:h}/../


# GNU utils; overwrites the Mac versions with plugin gnu-utils
brew install coreutils        # Install GNU core utils (those that come with macOS are outdated)
brew install findutils        # Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed
brew install gnu-sed          # Install GNU `sed`, overwriting the built-in `sed`
brew install gnupg            # Install GnuPG to enable PGP-signing commits.
brew install wget

# Install more recent versions of some macOS tools.
brew install git
brew install grep
brew install openssh
brew install screen
brew install vim

# Developer utils
brew install pygments
brew install ripgrep          # Super-fast grepping
brew cask install iterm2

# Install other useful binaries.
brew install imagemagick
brew install lynx             # Text-based web browser
brew install p7zip            # 7zip compression app
brew install tree             # file tree visualizer

# Full user applications (need to open manually the first time)
brew cask install 1password
brew cask install calibre
brew cask install handbrake
brew cask install jetbrains-toolbox     # Used to install and sync IntelliJ, etc
brew cask install qbittorrent
brew cask install quicken
brew cask install spotify
brew cask install vlc
brew cask install virtualbox
brew cask install virtualbox-extension-pack
brew cask install wireshark


# Remove outdated versions from the cellar.
brew cleanup
