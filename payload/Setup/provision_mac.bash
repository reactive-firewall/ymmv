#!/usr/bin/env bash

# original idea modified from (circa yet unlicensed April 2018 version):
# ~/.macos https://mths.be/macos

# Close any open System Preferences panes, to prevent them from overriding
# settings we're about to change
osascript -e 'tell application "System Preferences" to quit' || true

# Ask for the administrator password upfront
#sudo -v || exit 1 ;

# Keep-alive: update existing `sudo` time stamp until `.macos` has finished
#while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

###############################################################################
# General UI/UX                                                               #
###############################################################################

# Use export HOST="ComputerName"
# Set computer name (as done via System Preferences → Sharing)
if [[ ( -n $( scutil --get ComputerName | grep -F "$HOST" )) ]] ; then
sudo scutil --set ComputerName "$HOST"
sudo scutil --set HostName "$HOST"
sudo scutil --set LocalHostName "$HOST"
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "$HOST"
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server ServerDescription -string "$HOST"
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server AllowGuestAccess -bool NO
fi

# Set standby delay to 24 hours (default is 1 hour)
sudo pmset -a standbydelay 86400

# First restart

# Get the system hardware UUID
export HW_UUID=$(system_profiler -json SPHardwareDataType | grep -F "platform_UUID" | cut -d: -f 2 | tr -d '" ,')

# Disable the sound effects on boot
sudo nvram SystemAudioVolume=" "

# Second restart

# Automatic show scrollbars
defaults write NSGlobalDomain AppleShowScrollBars -string "Automatic" 2>/dev/null || true
# Possible values: `WhenScrolling`, `Automatic` and `Always`

# Disable smooth scrolling
# (Uncomment if you're on an older Mac that messes up the animation)
#defaults write NSGlobalDomain NSScrollAnimationEnabled -bool false

# Increase window resize speed for Cocoa applications
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

# Save to disk (not to iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Automatically quit printer app once the print jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# Enable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool true

# Remove duplicates in the “Open With” menu (also see `lscleanup` alias)
/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user

# Display ASCII control characters using caret notation in standard text views
# Try e.g. `cd /tmp; unidecode "\x{0000}" > cc.txt; open -e cc.txt`
#defaults write NSGlobalDomain NSTextShowsControlCharacters -bool true

# Disable Resume system-wide
defaults write com.apple.systempreferences NSQuitAlwaysKeepsWindows -bool false

# Disable automatic termination of inactive apps
#defaults write NSGlobalDomain NSDisableAutomaticTermination -bool true

# Disable the crash reporter
#defaults write com.apple.CrashReporter DialogType -string "none"

# Set Help Viewer windows to non-floating mode
defaults write com.apple.helpviewer DevMode -bool true

# Fix for the ancient UTF-8 bug in QuickLook (https://mths.be/bbo)
# Commented out, as this is known to cause problems in various Adobe apps :(
# See https://github.com/mathiasbynens/dotfiles/issues/237
# see setting in .bashrc instead
#echo "0x08000100:0" > ~/.CFUserTextEncoding

# Shows battery life percentage.
defaults write com.apple.menuextra.battery ShowPercent -string "YES"

# Reveal IP address, hostname, OS version, etc. when clicking the clock
# in the login window
sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName

# Restart automatically if the computer freezes
#sudo systemsetup -setrestartfreeze on

# Never go into computer sleep mode
#sudo systemsetup -setcomputersleep Off > /dev/null

# Disable Notification Center and remove the menu bar icon
#launchctl unload -w /System/Library/LaunchAgents/com.apple.notificationcenterui.plist 2>/dev/null

#disable 32 bit mode quicklook
sudo launchctl unload -w /System/Library/LaunchAgents/com.apple.quicklook.32bit.plist 2>/dev/null

# Disable automatic capitalization as it’s annoying when typing code
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

# Disable smart dashes as they’re annoying when typing code
#defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# Disable automatic period substitution as it’s annoying when typing code
#defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false

# Disable smart quotes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# Disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Set a custom wallpaper image. `DefaultDesktop.jpg` is already a symlink, and
# all wallpapers are in `/Library/Desktop Pictures/`. The default is `Wave.jpg`.
#rm -rf ~/Library/Application Support/Dock/desktoppicture.db
#sudo rm -rf /System/Library/CoreServices/DefaultDesktop.jpg
#sudo ln -s /path/to/your/image /System/Library/CoreServices/DefaultDesktop.jpg

###############################################################################
# Security Settings                                                           #
###############################################################################

# Seeds /dev/random and enables FileVault
if [[ $(sudo fdesetup status | head -1) == "FileVault is Off." ]]; then
openssl rand "$(($RANDOM * $RANDOM * $RANDOM * $RANDOM))" > /dev/random
sudo fdesetup enable -user $(whoami)
fi

# Enables auto updates
sudo softwareupdate --schedule on &> /dev/null

# Enable the automatic update check
defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true

# Check for software updates daily, not just once per week
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

# Download newly available updates in background
defaults write com.apple.SoftwareUpdate AutomaticDownload -int 1

# Installs System data files & security updates
defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -int 1

# Install updates to applications loaded via Mac App Store
defaults write com.apple.commerce AutoUpdate -bool true

# Disables AirDrop
defaults write com.apple.NetworkBrowser DisableAirDrop -bool true

# Disables the sending of diagnostic data to Apple
defaults write ~/Library/Preferences/ByHost/com.apple.SubmitDiagInfo.$HW_UUID AutoSubmit -bool false

# Disable Infared Remote
#sudo defaults write /Library/Preferences/com.apple.driver.AppleIRController DeviceEnabled -bool false

# Ensures screen locks immediately when requested
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Disables remote Apple Events
sudo systemsetup -setremoteappleevents off &> /dev/null

# Don’t open Bluetooth setup assistant if nothing's been detected
sudo defaults write /Library/Preferences/com.apple.Bluetooth BluetoothAutoSeekKeyboard -bool false
sudo defaults write /Library/Preferences/com.apple.Bluetooth BluetoothAutoSeekPointingDevice -bool false

# Forbid Bluetooth devices to wake the computer
defaults write ~/Library/Preferences/ByHost/com.apple.Bluetooth.$HW_UUID RemoteWakeEnabled -bool false

# Disables Bonjour Advertising
sudo defaults write /System/Library/LaunchDaemons/com.apple.mDNSResponder ProgramArguments -array-add "-NoMulticastAdvertisements" || true

# Disables remote login
sudo systemsetup -f -setremotelogin off &> /dev/null

# Disables Wake on Network Access
sudo systemsetup -setwakeonnetworkaccess off &> /dev/null

# Disables Remote Management
sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -deactivate -stop &> /dev/null

# Earliest point that is safe to reconnect to a network

###############################################################################
# Users & Groups                                                              #
###############################################################################

# Display login window as: Name and password
sudo defaults write /Library/Preferences/com.apple.loginwindow "SHOWFULLNAME" -bool true

# display warning:
sudo defaults write /Library/Preferences/com.apple.loginwindow LoginwindowText -string "Please provide valid authentication credentials"

# Disable automatic login
sudo defaults delete /Library/Preferences/com.apple.loginwindow autoLoginUser 2>/dev/null

# Forbids guest access to this computer
sudo defaults write /Library/Preferences/com.apple.loginwindow GuestEnabled -bool false
sudo defaults write /Library/Preferences/com.apple.loginwindow UseVoiceOverLegacyMigrated -bool false

# Disable guest access to shared folders
sudo defaults write /Library/Preferences/com.apple.AppleFileServer guestAccess -bool false
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server AllowGuestAccess -bool false

# CRITICAL: required for security (pre-login)
# Also enforced in .macrc at login
# Disable password hints
defaults write NSGlobalDomain RetriesUntilHint -int 0

# Hide sleep, restart, and shut down buttons in login window
sudo defaults write /Library/Preferences/com.apple.loginwindow PowerOffDisabled -bool true

# Disable input menu in login window
sudo defaults write /Library/Preferences/com.apple.loginwindow showInputMenu -bool false

# Disable console login - may make it near imposible to recover encrypted drive
#sudo defaults write /Library/Preferences/com.apple.loginwindow DisableConsoleAccess -bool true

# Disable external accounts
sudo defaults write /Library/Preferences/com.apple.loginwindow EnableExternalAccounts -bool false

# Hide non-local users on login window user list
sudo defaults write /Library/Preferences/com.apple.loginwindow SHOWOTHERUSERS_MANAGED -bool false

# Hide mobile users on login window
sudo defaults write /Library/Preferences/com.apple.loginwindow HideMobileAccounts -bool true

# Hide network users on login window
sudo defaults write /Library/Preferences/com.apple.loginwindow IncludeNetworkUser -bool false

# Disable fast user switching
sudo defaults write /Library/Preferences/.GlobalPreferences MultipleSessionEnabled -bool false


###############################################################################
# misc network and security tune                                              #
###############################################################################

# Disable Apple Push Notification Service daemon
# https://apple.stackexchange.com/questions/92214/how-to-disable-apple-push-notification-service-apsd-on-os-x-10-8
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.apsd.plist

# Disable CalendarAgent
#launchctl unload -w /System/Library/LaunchAgents/com.apple.CalendarAgent.plist

# Disable NetBIOS daemon (netbiosd)
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.netbiosd.plist

# Disable Location Services (locationd)
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.locationd.plist

# Disable Notification Center
# https://apple.stackexchange.com/questions/106149/how-do-i-permanently-disable-notification-center-in-mavericks
#sudo launchctl unload -w /System/Library/LaunchAgents/com.apple.notificationcenterui.plist

# Disable QuickLook
# https://superuser.com/questions/617658/quicklooksatellite-mac-os-high-cpu-use
#sudo launchctl unload -w /System/Library/LaunchAgents/com.apple.quicklook.*

# Disable Spotlight
# http://osxdaily.com/2011/12/10/disable-or-enable-spotlight-in-mac-os-x-lion/
#sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.metadata.mds.plist

# Disabling Maverick's Unicast ARP Cache Validation Script (thanks, MMV!)
# workaround for RFC 2211 § 2.3 bug in arp logic
bash <(curl -Ls https://raw.githubusercontent.com/MacMiniVault/Mac-Scripts/master/unicastarp/unicastarp.sh)

# Disable Bonjour Script (thanks MMV!)
#bash <(curl -Ls https://raw.githubusercontent.com/MacMiniVault/Mac-Scripts/master/disablebonjour/disablebonjour.sh)

###############################################################################
# SSD-specific tweaks                                                         #
###############################################################################

# Disable hibernation (speeds up entering sleep mode)
#sudo pmset -a hibernatemode 0

# Remove the sleep image file to save disk space
#sudo rm /private/var/vm/sleepimage
# Create a zero-byte file instead…
#sudo touch /private/var/vm/sleepimage
# …and make sure it can’t be rewritten
#sudo chflags uchg /private/var/vm/sleepimage

###############################################################################
# Trackpad, mouse, keyboard, Bluetooth accessories, and input                 #
###############################################################################

# Trackpad: enable tap to click for this user and for the login screen
#defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Trackpad: map bottom right corner to right-click
#defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadCornerSecondaryClick -int 2
# Enforced in .macrc at login
#defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true
#defaults -currentHost write NSGlobalDomain com.apple.trackpad.trackpadCornerClickBehavior -int 1
# Enforced in .macrc at login
#defaults -currentHost write NSGlobalDomain com.apple.trackpad.enableSecondaryClick -bool true

# Disable "natural" (Lion-style) scrolling
# Enforced in .macrc at login
#defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

# Increase sound quality for Bluetooth headphones/headsets
#defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40

# Enable full keyboard access for all controls
# (e.g. enable Tab in modal dialogs)
# Enforced in .macrc at login
#defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Use scroll gesture with the Ctrl (^) modifier key to zoom
#defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool true
#defaults write com.apple.universalaccess HIDScrollZoomModifierMask -int 262144
# Follow the keyboard focus while zoomed in
#defaults write com.apple.universalaccess closeViewZoomFollowsFocus -bool true

# CRITICAL: required for security (pre-login)
# Also enforced in .macrc at login
# Disable press-and-hold for keys in favor of key repeat
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Set a blazingly fast keyboard repeat rate
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 10

# Set language and text formats
defaults write NSGlobalDomain AppleLanguages -array "en_US" "en"
defaults write NSGlobalDomain AppleLocale -string "en_US"
defaults write NSGlobalDomain AppleMeasurementUnits -string "Inches"
defaults write NSGlobalDomain AppleMetricUnits -bool false

# Show language menu in the top right corner of the boot screen
#sudo defaults write /Library/Preferences/com.apple.loginwindow showInputMenu -bool true

# Set the timezone; see `sudo systemsetup -listtimezones` for other values
sudo systemsetup -settimezone "America/Los_Angeles" > /dev/null

# Stop iTunes from responding to the keyboard media keys
#launchctl unload -w /System/Library/LaunchAgents/com.apple.rcd.plist 2> /dev/null

###############################################################################
# Screen                                                                      #
###############################################################################

# Require password immediately after sleep or screen saver begins
# Enforced in .macrc at login
#defaults write com.apple.screensaver askForPassword -int 1
# Enforced in .macrc at login
#defaults write com.apple.screensaver askForPasswordDelay -int 0

# Save screenshots to the desktop
# Enforced in .macrc at login
#defaults write com.apple.screencapture location -string "${HOME}/Desktop"

# Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
# Enforced in .macrc at login
#defaults write com.apple.screencapture type -string "png"

# Disable shadow in screenshots
# Enforced in .macrc at login
#defaults write com.apple.screencapture disable-shadow -bool true

# Enable subpixel font rendering on non-Apple LCDs
# Reference: https://github.com/kevinSuttle/macOS-Defaults/issues/17#issuecomment-266633501
# Enforced in .macrc at login
#defaults write NSGlobalDomain AppleFontSmoothing -int 1

# Enable HiDPI display modes (requires restart)
sudo defaults write /Library/Preferences/com.apple.windowserver DisplayResolutionEnabled -bool true

###############################################################################
# Finder                                                                      #
###############################################################################

# Finder: allow quitting via ⌘ + Q; doing so will also hide desktop icons
#defaults write com.apple.finder QuitMenuItem -bool true

# Finder: disable window animations and Get Info animations
# Enforced in .macrc at login
#defaults write com.apple.finder DisableAllAnimations -bool true

# Set Desktop as the default location for new Finder windows
# For other paths, use `PfLo` and `file:///full/path/here/`
# values are "PfLo" and "PfDe"
# Enforced in .macrc at login
#defaults write com.apple.finder NewWindowTarget -string "PfLo"
# Enforced in .macrc at login
#defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"

# Show icons for hard drives, servers, and removable media on the desktop
# Enforced in .macrc at login
#defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
# Enforced in .macrc at login
#defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
# Enforced in .macrc at login
#defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
# Enforced in .macrc at login
#defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

# Finder: show hidden files by default
# Enforced in .macrc at login
#defaults write com.apple.finder AppleShowAllFiles -bool true

# Finder: show all filename extensions
# Enforced in .macrc at login
#defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Finder: show status bar
# Enforced in .macrc at login
#defaults write com.apple.finder ShowStatusBar -bool true

# Finder: show path bar
# Enforced in .macrc at login
#defaults write com.apple.finder ShowPathbar -bool true

# Display full POSIX path as Finder window title
# Enforced in .macrc at login
#defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# Keep folders on top when sorting by name
# Enforced in .macrc at login
#defaults write com.apple.finder _FXSortFoldersFirst -bool true

# When performing a search, search the current folder by default
# Enforced in .macrc at login
#defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Disable the warning when changing a file extension
# Enforced in .macrc at login
#defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Enable spring loading for directories
# Enforced in .macrc at login
#defaults write NSGlobalDomain com.apple.springing.enabled -bool true

# Remove the spring loading delay for directories
#defaults write NSGlobalDomain com.apple.springing.delay -float 0

# CRITICAL: required for security (recovery-mode)
# Also enforced in .macrc at login
# Avoid creating .DS_Store files on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Set disk image verification
# Enforced in .macrc at login
#defaults write com.apple.frameworks.diskimages skip-verify -bool false
# Enforced in .macrc at login
#defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
# Enforced in .macrc at login
#defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true

# Automatically open a new Finder window when a volume is mounted
# Enforced in .macrc at login
#defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
# Enforced in .macrc at login
#defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
#defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true

# Show item info near icons on the desktop and in other icon views
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist 2>/dev/null || true
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist 2>/dev/null || true

# Show item info to the right of the icons on the desktop
/usr/libexec/PlistBuddy -c "Set DesktopViewSettings:IconViewSettings:labelOnBottom false" ~/Library/Preferences/com.apple.finder.plist

# Enable snap-to-grid for icons on the desktop and in other icon views
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy kind" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy kind" ~/Library/Preferences/com.apple.finder.plist 2>/dev/null || true
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy kind" ~/Library/Preferences/com.apple.finder.plist 2>/dev/null || true

# Increase grid spacing for icons on the desktop and in other icon views
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:gridSpacing 80" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:gridSpacing 54" ~/Library/Preferences/com.apple.finder.plist 2>/dev/null || true
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:gridSpacing 100" ~/Library/Preferences/com.apple.finder.plist 2>/dev/null || true

# Increase the size of icons on the desktop and in other icon views
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:iconSize 128" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:iconSize 64" ~/Library/Preferences/com.apple.finder.plist 2>/dev/null || true
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:iconSize 192" ~/Library/Preferences/com.apple.finder.plist 2>/dev/null || true

# Use list view in all Finder windows by default
# Four-letter codes for the other view modes: `icnv`, `clmv`, `Flwv`
# Enforced in .macrc at login
#defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Disable the warning before emptying the Trash
defaults write com.apple.finder WarnOnEmptyTrash -bool false

# Enable AirDrop over Ethernet and on unsupported Macs running Lion
defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true

# Show the ~/Library folder
chflags nohidden ~/Library

# Show the /Volumes folder
sudo chflags nohidden /Volumes

# Remove Dropbox’s green checkmark icons in Finder
#file=/Applications/Dropbox.app/Contents/Resources/emblem-dropbox-uptodate.icns
#[ -e "${file}" ] && mv -f "${file}" "${file}.bak"

# Expand the following File Info panes:
# “General”, “Open with”, and “Sharing & Permissions”
defaults write com.apple.finder FXInfoPanesExpanded -dict Comments 1 General 1 MetaData 1 Name 0 OpenWith 1 Preview 1 Privileges 1

###############################################################################
# Dock, Dashboard, and hot corners                                            #
###############################################################################

# Enable highlight hover effect for the grid view of a stack (Dock)
#defaults write com.apple.dock mouse-over-hilite-stack -bool true

# Set the icon size of Dock items to 36 pixels
defaults write com.apple.dock tilesize -int 51

# Change minimize/maximize window effect
#defaults write com.apple.dock mineffect -string "scale"

# Minimize windows into their application’s icon
# Enforced in .macrc at login
#defaults write com.apple.dock minimize-to-application -bool true

# Enable spring loading for all Dock items
# Enforced in .macrc at login
#defaults write com.apple.dock enable-spring-load-actions-on-all-items -bool true

# Show indicator lights for open applications in the Dock
# Enforced in .macrc at login
#defaults write com.apple.dock show-process-indicators -bool true

# Wipe all (default) app icons from the Dock
# This is only really useful when setting up a new Mac, or if you don’t use
# the Dock to launch apps.
#defaults write com.apple.dock persistent-apps -array

# Show only open applications in the Dock
#defaults write com.apple.dock static-only -bool true

# Don’t animate opening applications from the Dock
# Enforced in .macrc at login
#defaults write com.apple.dock launchanim -bool false

# Speed up Mission Control animations
defaults write com.apple.dock expose-animation-duration -float 0.1

# Enable group windows by application in Mission Control
# (i.e. use the old Exposé behavior instead)
# Enforced in .macrc at login
#defaults write com.apple.dock expose-group-by-app -bool true

# Disable Dashboard
# Enforced in .macrc at login
#defaults write com.apple.dashboard mcx-disabled -bool true

# Don’t show Dashboard as a Space
# Enforced in .macrc at login
#defaults write com.apple.dock dashboard-in-overlay -bool true

# Don’t automatically rearrange Spaces based on most recent use
# Enforced in .macrc at login
#defaults write com.apple.dock mru-spaces -bool false

# Remove the auto-hiding Dock delay
#defaults write com.apple.dock autohide-delay -float 0
# Remove the animation when hiding/showing the Dock
#defaults write com.apple.dock autohide-time-modifier -float 0

# Automatically hide and show the Dock
# Enforced in .macrc at login
#defaults write com.apple.dock autohide -bool true

# Make Dock icons of hidden applications translucent
defaults write com.apple.dock showhidden -bool true

# Disable the Launchpad gesture (pinch with thumb and three fingers)
#defaults write com.apple.dock showLaunchpadGestureEnabled -int 0

# Reset Launchpad, but keep the desktop wallpaper intact
#find "${HOME}/Library/Application Support/Dock" -name "*-*.db" -maxdepth 1 -delete

# Add iOS & Watch Simulator to Launchpad
#sudo ln -sf "/Applications/Xcode.app/Contents/Developer/Applications/Simulator.app" "/Applications/Simulator.app"
#sudo ln -sf "/Applications/Xcode.app/Contents/Developer/Applications/Simulator (Watch).app" "/Applications/Simulator (Watch).app"

# Add a spacer to the left side of the Dock (where the applications are)
#defaults write com.apple.dock persistent-apps -array-add '{tile-data={}; tile-type="spacer-tile";}'
# Add a spacer to the right side of the Dock (where the Trash is)
# Enforced in .macrc at login
#defaults write com.apple.dock persistent-others -array-add '{tile-data={}; tile-type="spacer-tile";}'

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
# Top left screen corner -> Show application windows
defaults write com.apple.dock wvous-tl-corner -int 3
defaults write com.apple.dock wvous-tl-modifier -int 0
# Top right screen corner -> Mission Control
defaults write com.apple.dock wvous-tr-corner -int 2
defaults write com.apple.dock wvous-tr-modifier -int 0
# Bottom left screen corner -> Disable screen saver
defaults write com.apple.dock wvous-bl-corner -int 6
defaults write com.apple.dock wvous-bl-modifier -int 0

###############################################################################
# Safari & WebKit                                                             #
###############################################################################

# Privacy: don’t send search queries to Apple
# Enforced in .macrc at login
#defaults write com.apple.Safari UniversalSearchEnabled -bool false
# Enforced in .macrc at login
#defaults write com.apple.Safari SuppressSearchSuggestions -bool true

# Press Tab to highlight each item on a web page
# Enforced in .macrc at login
#defaults write com.apple.Safari WebKitTabToLinksPreferenceKey -bool true
# Enforced in .macrc at login
#defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2TabsToLinks -bool true

# CRITICAL: required for security (recovery-mode)
# Also enforced in .macrc at login
# Show the full URL in the address bar (note: this still hides the scheme)
defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true

# CRITICAL: required for security (recovery-mode)
# Set Safari’s home page to `about:blank` for faster loading
defaults write com.apple.Safari HomePage -string "about:blank"

# CRITICAL: required for security (recovery-mode)
# Prevent Safari from opening ‘safe’ files automatically after downloading
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false

# Allow hitting the Backspace key to go to the previous page in history
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2BackspaceKeyNavigationEnabled -bool false

# Hide Safari’s bookmarks bar by default
# Enforced in .macrc at login
#defaults write com.apple.Safari ShowFavoritesBar -bool false

# Hide Safari’s sidebar in Top Sites
# Enforced in .macrc at login
#defaults write com.apple.Safari ShowSidebarInTopSites -bool false

# Disable Safari’s thumbnail cache for History and Top Sites
# Enforced in .macrc at login
#defaults write com.apple.Safari DebugSnapshotsUpdatePolicy -int 2

# Enable Safari’s debug menu
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

# Make Safari’s search banners default to Contains instead of Starts With
# Enforced in .macrc at login
#defaults write com.apple.Safari FindOnPageMatchesWordStartsOnly -bool false

# Remove useless icons from Safari’s bookmarks bar
# default ProxiesInBookmarksBar =     -array ("Reading List");
defaults write com.apple.Safari ProxiesInBookmarksBar "()"

# Enable the Develop menu and the Web Inspector in Safari
# Enforced in .macrc at login
#defaults write com.apple.Safari IncludeDevelopMenu -bool true
# Enforced in .macrc at login
#defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
# Enforced in .macrc at login
#defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true

# Add a context menu item for showing the Web Inspector in web views
# Enforced in .macrc at login
#defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

# Enable continuous spellchecking
# Enforced in .macrc at login
#defaults write com.apple.Safari WebContinuousSpellCheckingEnabled -bool true
# Disable auto-correct
# Enforced in .macrc at login
#defaults write com.apple.Safari WebAutomaticSpellingCorrectionEnabled -bool false

# CRITICAL: required for security (recovery-mode)
# Also enforced in .macrc at login
# Disable AutoFill
defaults write com.apple.Safari AutoFillFromAddressBook -bool false
defaults write com.apple.Safari AutoFillPasswords -bool false
defaults write com.apple.Safari AutoFillCreditCardData -bool false
defaults write com.apple.Safari AutoFillMiscellaneousForms -bool false

# Warn about fraudulent websites
# Enforced in .macrc at login
#defaults write com.apple.Safari WarnAboutFraudulentWebsites -bool true
# Enforced in .macrc at login
#defaults write com.apple.Safari AskBeforeSubmittingInsecureForms -bool true
# Enforced in .macrc at login
#defaults write com.apple.Safari TreatSHA1CertificatesAsInsecure -bool true

# Disable plug-ins
# Enforced in .macrc at login
#defaults write com.apple.Safari WebKitPluginsEnabled -bool false
# Enforced in .macrc at login
#defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2PluginsEnabled -bool false

# Disable Java
# Enforced in .macrc at login
#defaults write com.apple.Safari WebKitJavaEnabled -bool false
# Enforced in .macrc at login
#defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaEnabled -bool false

# Block pop-up windows
# Enforced in .macrc at login
#defaults write com.apple.Safari WebKitJavaScriptCanOpenWindowsAutomatically -bool false
# Enforced in .macrc at login
#defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaScriptCanOpenWindowsAutomatically -bool false

# Disable auto-playing video
# Enforced in .macrc at login
#defaults write com.apple.Safari WebKitMediaPlaybackAllowsInline -bool false
# Enforced in .macrc at login
#defaults write com.apple.SafariTechnologyPreview WebKitMediaPlaybackAllowsInline -bool false
# Enforced in .macrc at login
#defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2AllowsInlineMediaPlayback -bool false
# Enforced in .macrc at login
#defaults write com.apple.SafariTechnologyPreview com.apple.Safari.ContentPageGroupIdentifier.WebKit2AllowsInlineMediaPlayback -bool false

# Enable “Do Not Track”
# Enforced in .macrc at login
#defaults write com.apple.Safari SendDoNotTrackHTTPHeader -bool true

# Update extensions automatically
# Enforced in .macrc at login
#defaults write com.apple.Safari InstallExtensionUpdatesAutomatically -bool true

###############################################################################
# Mail                                                                        #
###############################################################################

# Disable send and reply animations in Mail.app
defaults write com.apple.mail DisableReplyAnimations -bool true
defaults write com.apple.mail DisableSendAnimations -bool true

# Copy email addresses as `foo@example.com` instead of `Foo Bar <foo@example.com>` in Mail.app
# Enforced in .macrc at login
#defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false

# Add the keyboard shortcut ⌘ + Enter to send an email in Mail.app
#defaults write com.apple.mail NSUserKeyEquivalents -dict-add "Send" "@\U21a9"

# Display emails in threaded mode, sorted by date (oldest at the top)
# Enforced in .macrc at login
#defaults write com.apple.mail DraftsViewerAttributes -dict-add "DisplayInThreadedMode" -string "yes"
# Enforced in .macrc at login
#defaults write com.apple.mail DraftsViewerAttributes -dict-add "SortedDescending" -string "yes"
# Enforced in .macrc at login
#defaults write com.apple.mail DraftsViewerAttributes -dict-add "SortOrder" -string "received-date"

# Disable inline attachments (just show the icons)
# Enforced in .macrc at login
#defaults write com.apple.mail DisableInlineAttachmentViewing -bool true

# Enable automatic spell checking (other options: "NoSpellCheckingEnabled")
# Enforced in .macrc at login
#defaults write com.apple.mail SpellCheckingBehavior -string "InlineSpellCheckingEnabled"


defaults write com.apple.dashboard mcx-disabled -boolean YES && killall Dock

#https://raw.githubusercontent.com/l1k/osxparanoia/master/sysctl.conf

###############################################################################
# Spotlight                                                                   #
###############################################################################

# Hide Spotlight tray-icon (and subsequent helper)
#sudo chmod 600 /System/Library/CoreServices/Search.bundle/Contents/MacOS/Search
# Disable Spotlight indexing for any volume that gets mounted and has not yet
# been indexed before.
# Use `sudo mdutil -i off "/Volumes/foo"` to stop indexing any volume.
sudo defaults write /.Spotlight-V100/VolumeConfiguration Exclusions -array "/Volumes"
# Change indexing order and disable some search results
# Yosemite-specific search results (remove them if you are using macOS 10.9 or older):
# 	MENU_DEFINITION
# 	MENU_CONVERSION
# 	MENU_EXPRESSION
# 	MENU_SPOTLIGHT_SUGGESTIONS (send search queries to Apple)
# 	MENU_WEBSEARCH             (send search queries to Apple)
# 	MENU_OTHER
# Enforced in .macrc at login
#defaults write com.apple.spotlight orderedItems -array \
#	'{"enabled" = 1;"name" = "APPLICATIONS";}' \
#	'{"enabled" = 1;"name" = "SYSTEM_PREFS";}' \
#	'{"enabled" = 1;"name" = "DIRECTORIES";}' \
#	'{"enabled" = 1;"name" = "PDF";}' \
#	'{"enabled" = 1;"name" = "FONTS";}' \
#	'{"enabled" = 1;"name" = "DOCUMENTS";}' \
#	'{"enabled" = 0;"name" = "MESSAGES";}' \
#	'{"enabled" = 0;"name" = "CONTACT";}' \
#	'{"enabled" = 0;"name" = "EVENT_TODO";}' \
#	'{"enabled" = 1;"name" = "IMAGES";}' \
#	'{"enabled" = 0;"name" = "BOOKMARKS";}' \
#	'{"enabled" = 0;"name" = "MUSIC";}' \
#	'{"enabled" = 0;"name" = "MOVIES";}' \
#	'{"enabled" = 0;"name" = "PRESENTATIONS";}' \
#	'{"enabled" = 0;"name" = "SPREADSHEETS";}' \
#	'{"enabled" = 0;"name" = "SOURCE";}' \
#	'{"enabled" = 1;"name" = "MENU_DEFINITION";}' \
#	'{"enabled" = 0;"name" = "MENU_OTHER";}' \
#	'{"enabled" = 0;"name" = "MENU_CONVERSION";}' \
#	'{"enabled" = 1;"name" = "MENU_EXPRESSION";}' \
#	'{"enabled" = 0;"name" = "MENU_WEBSEARCH";}' \
#	'{"enabled" = 0;"name" = "MENU_SPOTLIGHT_SUGGESTIONS";}'
# Load new settings before rebuilding the index
killall mds > /dev/null 2>&1
# Make sure indexing is enabled for the main volume
sudo mdutil -i on / > /dev/null ;
# Rebuild the index from scratch
sudo mdutil -E / > /dev/null ;

###############################################################################
# Terminal & iTerm 2                                                          #
###############################################################################

# Only use UTF-8 in Terminal.app
# Enforced in .macrc at login
#defaults write com.apple.terminal StringEncodings -array 4 30

# Enable “focus follows mouse” for Terminal.app and all X11 apps
# i.e. hover over a window and start typing in it without clicking first
#defaults write com.apple.terminal FocusFollowsMouse -bool true
#defaults write org.x.X11 wm_ffm -bool true

# CRITICAL: required for security (pre-login)
# Also enforced in .macrc at login
# disable remote X11 socket
defaults write org.x.X11 nolisten_tcp -bool true

# Enable Secure Keyboard Entry in Terminal.app
# See: https://security.stackexchange.com/a/47786/8918
# Enforced in .macrc at login
#defaults write com.apple.terminal SecureKeyboardEntry -bool true

# Disable the annoying line marks
# Enforced in .macrc at login
#defaults write com.apple.Terminal ShowLineMarks -int 0

# Install the Solarized Dark theme for iTerm
# open "${HOME}/init/Solarized Dark.itermcolors"

# Don’t display the annoying prompt when quitting iTerm
# defaults write com.googlecode.iterm2 PromptOnQuit -bool false

###############################################################################
# Time Machine                                                                #
###############################################################################

# Prevent Time Machine from prompting to use new hard drives as backup volume
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

# Disable local Time Machine backups
hash tmutil 2>/dev/null && sudo tmutil disablelocal

###############################################################################
# Activity Monitor                                                            #
###############################################################################

# Show the main window when launching Activity Monitor
# Enforced in .macrc at login
#defaults write com.apple.ActivityMonitor OpenMainWindow -bool true

# Visualize CPU usage in the Activity Monitor Dock icon
#defaults write com.apple.ActivityMonitor IconType -int 5

# Show all processes in Activity Monitor
# Enforced in .macrc at login
#defaults write com.apple.ActivityMonitor ShowCategory -int 0

# Sort Activity Monitor results by CPU usage
# Enforced in .macrc at login
#defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
# Enforced in .macrc at login
#defaults write com.apple.ActivityMonitor SortDirection -int 0

###############################################################################
# Address Book, Dashboard, iCal, TextEdit, and Disk Utility                   #
###############################################################################

# Enable the debug menu in Address Book
# Enforced in .macrc at login
#defaults write com.apple.addressbook ABShowDebugMenu -bool true

# Enable Dashboard dev mode (allows keeping widgets on the desktop)
# Enforced in .macrc at login
#defaults write com.apple.dashboard devmode -bool true

# Enable the debug menu in iCal (pre-10.8)
#defaults write com.apple.iCal IncludeDebugMenu -bool true

#enable timezone support
# Enforced in .macrc at login
#defaults write com.apple.iCal "TimeZone support enabled" -bool true


# Use plain text mode for new TextEdit documents
# Enforced in .macrc at login
#defaults write com.apple.TextEdit RichText -int 0
# Open and save files as UTF-8 in TextEdit (4 = UTF-8, 10 = UTF-16)
# Enforced in .macrc at login
#defaults write com.apple.TextEdit PlainTextEncoding -int 4
defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4

# Enable the debug menu in Disk Utility
# Enforced in .macrc at login
#defaults write com.apple.DiskUtility DUDebugMenuEnabled -bool true
# Enforced in .macrc at login
#defaults write com.apple.DiskUtility advanced-image-options -bool true

# Auto-play videos when opened with QuickTime Player
# Enforced in .macrc at login
#defaults write com.apple.QuickTimePlayerX MGPlayMovieOnOpen -bool true

###############################################################################
# Mac App Store                                                               #
###############################################################################

# CRITICAL: required for security (pre-login)
# Also enforced in .macrc at login
# Enable the WebKit Developer Tools in the Mac App Store
defaults write com.apple.appstore WebKitDeveloperExtras -bool true

# CRITICAL: required for security (pre-login)
# Also enforced in .macrc at login
# Enable Debug Menu in the Mac App Store
defaults write com.apple.appstore ShowDebugMenu -bool true

# CRITICAL: required for security (pre-login)
# Also enforced in .macrc at login
# Enable the automatic update check
defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true

# CRITICAL: required for security (pre-login)
# Also enforced in .macrc at login
# Check for software updates daily, not just once per week
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

# CRITICAL: required for security (pre-login)
# Also enforced in .macrc at login
# Download newly available updates in background
defaults write com.apple.SoftwareUpdate AutomaticDownload -int 1

# CRITICAL: required for security (pre-login)
# Also enforced in .macrc at login
# Install System data files & security updates
defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -int 1

# CRITICAL: required for security (pre-login)
# Also enforced in .macrc at login
# Disable Automatically download apps purchased on other Macs
defaults write com.apple.SoftwareUpdate ConfigDataInstall -int 0

# CRITICAL: required for security (pre-login)
# Turn off app auto-update
defaults write com.apple.commerce AutoUpdate -bool false

# CRITICAL: required for security (pre-login)
# Allow the App Store to reboot machine on macOS updates
defaults write com.apple.commerce AutoUpdateRestartRequired -bool true

###############################################################################
# Photos                                                                      #
###############################################################################

# CRITICAL: required for security (pre-login)
# Also enforced in .macrc at login
# Prevent Photos from opening automatically when devices are plugged in
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true

###############################################################################
# Messages                                                                    #
###############################################################################

# Disable automatic emoji substitution (i.e. use plain text smileys)
#defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticEmojiSubstitutionEnablediMessage" -bool false

# Disable smart quotes as it’s annoying for messages that contain code
#defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticQuoteSubstitutionEnabled" -bool false

# Disable continuous spell checking
#defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "continuousSpellCheckingEnabled" -bool false

###############################################################################
# Google Chrome & Google Chrome Canary                                        #
###############################################################################

# Disable the all too sensitive backswipe on trackpads
#defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool false
#defaults write com.google.Chrome.canary AppleEnableSwipeNavigateWithScrolls -bool false

# Disable the all too sensitive backswipe on Magic Mouse
#defaults write com.google.Chrome AppleEnableMouseSwipeNavigateWithScrolls -bool false
#defaults write com.google.Chrome.canary AppleEnableMouseSwipeNavigateWithScrolls -bool false

# Use the system-native print preview dialog
#defaults write com.google.Chrome DisablePrintPreview -bool true
#defaults write com.google.Chrome.canary DisablePrintPreview -bool true

# Expand the print dialog by default
#defaults write com.google.Chrome PMPrintingExpandedStateForPrint2 -bool true
#defaults write com.google.Chrome.canary PMPrintingExpandedStateForPrint2 -bool true

###############################################################################
# GPGMail 2                                                                   #
###############################################################################

# Disable signing emails by default
#defaults write ~/Library/Preferences/org.gpgtools.gpgmail SignNewEmailsByDefault -bool false

###############################################################################
# Opera & Opera Developer                                                     #
###############################################################################

# Expand the print dialog by default
#defaults write com.operasoftware.Opera PMPrintingExpandedStateForPrint2 -boolean true
#defaults write com.operasoftware.OperaDeveloper PMPrintingExpandedStateForPrint2 -boolean true


###############################################################################
# Sublime Text                                                                #
###############################################################################

# Install Sublime Text settings
#cp -r init/Preferences.sublime-settings ~/Library/Application\ Support/Sublime\ Text*/Packages/User/Preferences.sublime-settings 2> /dev/null || true

###############################################################################
# Yamaha Studio Manager                                                       #
###############################################################################

defaults write /Library/Preferences/com.steinberg.sm2.plist "Load Yamaha Studio Manager" -bool true

###############################################################################
# Twitter.app                                                                 #
###############################################################################

# Disable smart quotes as it’s annoying for code tweets
defaults write com.twitter.twitter-mac AutomaticQuoteSubstitutionEnabled -bool false

# Show the app window when clicking the menu bar icon
# defaults write com.twitter.twitter-mac MenuItemBehavior -int 1

# Enable the hidden ‘Develop’ menu
defaults write com.twitter.twitter-mac ShowDevelopMenu -bool true

# DON'T Open links in the background
defaults write com.twitter.twitter-mac openLinksInBackground -bool false

# Allow closing the ‘new tweet’ window by pressing `Esc`
defaults write com.twitter.twitter-mac ESCClosesComposeWindow -bool true

# Show full names rather than Twitter handles
defaults write com.twitter.twitter-mac ShowFullNames -bool true

# DON'T Hide the app in the background if it’s not the front-most window
defaults write com.twitter.twitter-mac HideInBackground -bool false

###############################################################################
# Tweetbot.app                                                                #
###############################################################################

# Bypass the annoyingly slow t.co URL shortener
defaults write com.tapbots.TweetbotMac OpenURLsDirectly -bool true

###############################################################################
# Optimize for SecDevOps                                                      #
###############################################################################

# lock down gamed "phone home" leaks
sudo /usr/libexec/ApplicationFirewall/socketfilterfw -add /System/Library/PrivateFrameworks/GameCenterFoundation.framework/Versions/A/gamed
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --blockapp /System/Library/PrivateFrameworks/GameCenterFoundation.framework/Versions/A/gamed
sudo defaults write /System/Library/LaunchAgents/com.apple.gamed EnableTransactions -bool false
sudo defaults write /System/Library/LaunchAgents/com.apple.gamed disabled -bool true
sudo launchctl unload -w /System/Library/LaunchAgents/com.apple.gamed*

# lock down yellow pages "phone home" leak
sudo /usr/libexec/ApplicationFirewall/socketfilterfw -add /usr/sbin/ypbind
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --blockapp /usr/sbin/ypbind
sudo defaults write /System/Library/LaunchAgents/com.apple.nis.ypbind disabled -bool true
sudo launchctl unload -w /System/Library/LaunchAgents/com.apple.nis.ypbind*

# block 32bit quicklook from network usage
sudo /usr/libexec/ApplicationFirewall/socketfilterfw -add /System/Library/Frameworks/QuickLook.framework/Resources/quicklookd32.app/Contents/MacOS/quicklookd32
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --blockapp /System/Library/Frameworks/QuickLook.framework/Resources/quicklookd32.app/Contents/MacOS/quicklookd32
sudo defaults write /System/Library/LaunchAgents/com.apple.quicklook.32bit.plist disabled -bool true
sudo launchctl unload -w /System/Library/LaunchAgents/com.apple.quicklook.32bit* 2>/dev/null

# block SMB guests:
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server.plist AllowGuestAccess -int 0

#com.apple.security.FDERecoveryAgent ? is this safe?

# prevent mitm attack
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.captive.control Active -bool false
# sudo rm -f /Library/Preferences/SystemConfiguration/CaptiveNetworkSupport/Settings.plist
sudo rm -f /Library/Preferences/SystemConfiguration/com.apple.captive.probe.plist


# clear boot options (can break auto install)
#sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.Boot.plist "Kernel Flags" -string ""

###############################################################################
# Kill affected applications                                                  #
###############################################################################

for app in "Activity Monitor" \
	"Address Book" \
	"Calendar" \
	"cfprefsd" \
	"Contacts" \
	"Dock" \
	"Finder" \
	"Google Chrome Canary" \
	"Google Chrome" \
	"Mail" \
	"Messages" \
	"Opera" \
	"Photos" \
	"Safari" \
	"SizeUp" \
	"Spectacle" \
	"Transmission" \
	"Tweetbot" \
	"Twitter" \
	"iCal" \
	"SystemUIServer" \
	"Terminal"; do
	killall "${app}" &> /dev/null
done
echo "Done. Note that some of these changes require a logout/restart to take effect."
