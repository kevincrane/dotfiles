#!/usr/bin/env zsh

# This is a cheap hack to ensure we don't install a bunch of extra apps on work computers
HOME_COMPUTER='kcrane-mbp'

# Install command-line tools using Homebrew.
brew update                   # Make sure we’re using the latest Homebrew.
brew upgrade                  # Upgrade any already-installed formulae.

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
# brew install openssh
brew install screen
brew install vim

# Developer utils
brew install bat              # 'cat' with highlighting and paging
brew install fd               # Alternative to 'find'
brew install go
brew install node
brew install pygments
brew install ripgrep          # Super-fast grepping
brew install --cask iterm2

# Install other useful binaries.
brew install imagemagick
brew install lynx             # Text-based web browser
brew install p7zip            # 7zip compression app
brew install tree             # file tree visualizer

# Full user applications (need to open manually the first time)
# NB: only installs these apps on the "home computer"
if [[ $(hostname) =~ $HOME_COMPUTER ]]; then
  brew install --cask 1password             # Creates a .app file in /Applications
  brew install --cask --appdir="~/Applications" arduino
  brew install --cask --appdir="~/Applications" calibre
  brew install --cask --appdir="~/Applications" handbrake
  brew install --cask --appdir="~/Applications" jetbrains-toolbox     # Used to install and sync IntelliJ, etc
  brew install --cask --appdir "/Applications" little-snitch          # License in email
  brew install --cask --appdir="~/Applications" qbittorrent
  brew install --cask --appdir="~/Applications" quicken               # Creates a .app file in /Applications
  brew install --cask --appdir="~/Applications" spotify               # Creates a .app file in /Applications
  brew install --cask --appdir="~/Applications" vlc                   # Creates a .app file in /Applications
  brew install --cask virtualbox
  brew install --cask virtualbox-extension-pack
  brew install --cask --appdir="~/Applications" wireshark
fi


# Remove outdated versions from the cellar.
brew cleanup
