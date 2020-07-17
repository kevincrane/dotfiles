#!/usr/bin/env zsh

# ~/.macos — https://mths.be/macos

echo "=> Setting default Mac preferences & settings"

# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.macos` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &


###############################################################################
# General UI/UX                                                               #
###############################################################################

# Always show scrollbars
defaults write NSGlobalDomain AppleShowScrollBars -string "Always"

# Expand save & print panels by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

# Automatically quit printer app once the print jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# Disable the “Are you sure you want to open this application?” dialog
# defaults write com.apple.LaunchServices LSQuarantine -bool false

# Disable various text corrections
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false      # auto-capitalization
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false    # smart dashes
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false  # automatic period after sentence
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false   # smart quotes
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false  # auto-correct


###############################################################################
# Trackpad, mouse, keyboard, and input                                        #
###############################################################################

# Trackpad: dragging with drag lock
for device in "AppleMultitouchTrackpad" "driver.AppleBluetoothMultitouch.trackpad"; do
  # Tap to click
  defaults write com.apple.$device Clicking -bool true
  defaults write com.apple.$device TrackpadRightClick -bool true

  # Dragging with draglock
  defaults write com.apple.$device Dragging -bool true
  defaults write com.apple.$device DragLock -bool true

  # Trackpad gestures
  defaults write com.apple.$device TrackpadThreeFingerHorizSwipeGesture -int 2        # change spaces
  defaults write com.apple.$device TrackpadThreeFingerVertSwipeGesture -int 2         # mission control/expose
  defaults write com.apple.$device TrackpadTwoFingerFromRightEdgeSwipeGesture -int 3  # notification center
done

# Disable "natural" scrolling
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

# Enable Tab in modal dialogs
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3


###############################################################################
# Energy saving                                                               #
###############################################################################

# Enable lid wakeup
sudo pmset -a lidwake 1

# Restart automatically if the computer freezes
sudo systemsetup -setrestartfreeze on

# Sleep the display after N minutes
sudo pmset -b displaysleep 5    # battery
sudo pmset -c displaysleep 10   # charger

# Set machine sleep after N minutes
sudo pmset -b sleep 5     # battery
sudo pmset -c sleep 10    # charger

# Disks go to sleep after 10 minutes
sudo pmset -a disksleep 10


###############################################################################
# Screen Saver & Display                                                      #
###############################################################################

# Require password immediately after sleep or screen saver begins
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Enable subpixel font rendering on non-Apple LCDs
# Reference: https://github.com/kevinSuttle/macOS-Defaults/issues/17#issuecomment-266633501
defaults write NSGlobalDomain AppleFontSmoothing -int 1

# Enable HiDPI display modes (requires restart)
sudo defaults write /Library/Preferences/com.apple.windowserver DisplayResolutionEnabled -bool true


###############################################################################
# Finder                                                                      #
###############################################################################

# Finder: allow quitting via Cmd+Q; doing so will also hide desktop icons
defaults write com.apple.finder QuitMenuItem -bool true

# Finder: show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Finder: show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Finder: show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# Sort files by name by default in Icon View
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy name" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy name" ~/Library/Preferences/com.apple.finder.plist

# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Avoid creating .DS_Store files on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Show the ~/Library & /Volumes folders
chflags nohidden ~/Library
sudo chflags nohidden /Volumes

# Expand the following File Info panes:
# “General”, “Open with”
defaults write com.apple.finder FXInfoPanesExpanded -dict \
    General -bool true \
    MetaData -bool true \
    OpenWith -bool true \
    Name -bool false


###############################################################################
# Dock and hot corners                                                        #
###############################################################################

defaults write com.apple.dock orientation -string left
defaults write com.apple.dock show-process-indicators -bool true
defaults write com.apple.dock autohide -bool false
defaults write com.apple.dock magnification -bool true
defaults write com.apple.dock largesize -int 71  # size dock magnifies to

# Set sidebar icon size to medium
defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 2

# Hot corners
# Possible values:
#  0: no-op
#  2: Mission Control
#  3: Show application windows
#  4: Desktop
#  5: Start screen saver
#  6: Disable screen saver
#  7: Dashboard
# 10: Put display to sleep
# 11: Launchpad
# 12: Notification Center
# 13: Lock Screen
# Top left screen corner → Mission Control
defaults write com.apple.dock wvous-bl-corner -int 3  # bottom-left: application windows
defaults write com.apple.dock wvous-bl-modifier -int 0
defaults write com.apple.dock wvous-br-corner -int 4  # bottom-right: desktop
defaults write com.apple.dock wvous-br-modifier -int 0
defaults write com.apple.dock wvous-tl-corner -int 2  # top-left: mission control
defaults write com.apple.dock wvous-tl-modifier -int 0
defaults write com.apple.dock wvous-tr-corner -int 5  # top-right: screensaver
defaults write com.apple.dock wvous-tr-modifier -int 0


###############################################################################
# Terminal & iTerm 2                                                          #
###############################################################################

# Enable Secure Keyboard Entry in Terminal.app
# See: https://security.stackexchange.com/a/47786/8918
defaults write com.apple.terminal SecureKeyboardEntry -bool true

# Disable the annoying line marks
defaults write com.apple.Terminal ShowLineMarks -int 0


###############################################################################
# Miscellaneous                                                               #
###############################################################################


###############################################################################
# Kill affected applications                                                  #
###############################################################################
echo "=> Done setting Mac preferences; killing affected apps to pick up new settings"

for app in "cfprefsd" \
    "Dock" \
    "Finder" \
    "SystemUIServer"; do
    killall "${app}" &> /dev/null
done
echo "=> Done. Note that some of these changes require a logout/restart to take effect."
