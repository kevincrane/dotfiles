### MacOS Aliases ###

# Get macOS Software Updates, and update Homebrew
alias update='sudo softwareupdate -i -a; brew update; brew upgrade; brew cleanup'
# Recursively delete `.DS_Store` files
alias cleanup_ds="find . -type f -name '*.DS_Store' -ls -delete"

# Show/hide hidden files in Finder
alias show="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
alias hide="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"

# Disable Spotlight
alias spotoff="sudo mdutil -a -i off"
# Enable Spotlight
alias spoton="sudo mdutil -a -i on"
