#!/bin/bash

#osascript -e 'tell application "System Preferences" to quit' || true

# Ask for the administrator password upfront

# Use export HOSTNAME="ComputerName"
export HOSTNAME=${HOSTNAME:-"ComputerName"}

# Set computer name (as done via System Preferences -> Sharing)
if [[ ( -n $( scutil --get ComputerName | grep -voF "$HOSTNAME" )) ]] ; then
sudo scutil --set ComputerName "$HOSTNAME"
sudo scutil --set HostName "$HOSTNAME"
sudo scutil --set LocalHostName "$HOSTNAME"
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "$HOSTNAME"
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server ServerDescription -string "$HOSTNAME"
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server AllowGuestAccess -bool NO
fi

# Get the system hardware UUID
#export HW_UUID=$(system_profiler -json SPHardwareDataType | grep -F "platform_UUID" | cut -d: -f 2 | tr -d '" ,')
