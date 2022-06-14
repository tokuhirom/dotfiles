#!/bin/bash

# diff -U 20  /tmp/orig =(defaults read) とかして見つける。



# Use dark mode
defaults write -globalDomain AppleInterfaceStyle -string "Dark"

# keyrepeat
defaults write -g InitialKeyRepeat -int 15 # normal minimum is 15 (225 ms)
defaults write -g KeyRepeat -int 2 # normal minimum is 2 (30 ms)


# Auto-hide dock`
osascript -e 'tell application "System Events" to set the autohide of the dock preferences to true'

# Disable SmartQuotes
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# Set CapsLock to Control (1452-628-0 is your product ID)
defaults -currentHost write -g com.apple.keyboard.modifiermapping.1452-628-0 -array "<dict><key>HIDKeyboardModifierMappingSrc</key><integer>30064771129</integer><key>HIDKeyboardModifierMappingDst</key><integer>30064771296</integer></dict>"

# ------------------------------------------------------------------------- 
# Key shortcuts
# https://superuser.com/questions/1211108/remove-osx-spotlight-keyboard-shortcut-from-command-line
#
# This may needs rebooting
# -------------------------------------------------------------------------

# Select the previous input source
/usr/libexec/PlistBuddy -c "Set AppleSymbolicHotKeys:60:enabled false" ~/Library/Preferences/com.apple.symbolichotkeys.plist
# Select the next input source
/usr/libexec/PlistBuddy -c "Set AppleSymbolicHotKeys:61:enabled false" ~/Library/Preferences/com.apple.symbolichotkeys.plist
# Disable spotlight
/usr/libexec/PlistBuddy -c "Set AppleSymbolicHotKeys:64:enabled false" ~/Library/Preferences/com.apple.symbolichotkeys.plist



# ------------------------------------------------------------------------- 
# Finder
# -------------------------------------------------------------------------

# Finder: show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true


# See also
# https://github.com/roife/mac-setup/blob/5f77bac9d1667980bd087ced1f1fa2573b2fc1f1/macos.sh

