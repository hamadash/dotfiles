#!/bin/zsh

if [ "$(uname)" != "Darwin" ] ; then
  echo "Not macOS!"
  exit 1
fi

# ====================
#
# Dock
#
# ====================

# defaults write com.apple.dock orientation -string "right"

defaults write com.apple.dock tilesize -integer 16

defaults write com.apple.dock magnification -integer 1

defaults write com.apple.dock largesize -int 100

# ====================
#
# Finder
#
# ====================

# Disable animation
defaults write com.apple.finder DisableAllAnimations -bool true

# Show hidden files by default
defaults write com.apple.finder AppleShowAllFiles -bool true

# Show files with all extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Display the status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Display the path bar
defaults write com.apple.finder ShowPathbar -bool true

# ====================
#
# Keyboard
#
# ====================

defaults write -g InitialKeyRepeat -int 11

defaults write -g KeyRepeat -int 1

# Change modifiermapping from CapsLock to Ctrl
keyboard_id="$(ioreg -c AppleEmbeddedKeyboard -r | grep -Eiw "VendorID|ProductID" | awk '{ print $4 }' | paste -s -d'-\n' -)-0"
defaults -currentHost write -g com.apple.keyboard.modifiermapping.${keyboard_id} -array-add "
<dict>
  <key>HIDKeyboardModifierMappingDst</key>\
  <integer>30064771300</integer>\
  <key>HIDKeyboardModifierMappingSrc</key>\
  <integer>30064771129</integer>\
</dict>
"

# TODO:
# - 各FunctionキーとFnキー同時押し時の設定
# - Fnキー単推し時の設定

# ====================
#
# SystemUIServer
#
# ====================

# Display date, day, and time in the menu bar
defaults write com.apple.menuextra.clock DateFormat -string "EEE d MMM HH:mm"

# Display battery level in the menu bar
defaults write com.apple.menuextra.battery ShowPercent -string "YES"

# ====================
#
# TrackPad
#
# ====================

defaults write com.apple.AppleMultitouchTrackpad Clicking -bool "true"

for app in "Dock" \
  "Finder" \
  "SystemUIServer"; do
  killall "${app}" &> /dev/null
done
