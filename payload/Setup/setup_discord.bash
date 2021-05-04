#! /bin/bash

if [[ $( \uname -s ) == "Darwin" ]] ; then
#sudo softwareupdate --install --recommended || true

hash -p $(dirname $0)/../bin/sud sud

# this takes some time:
sud "https://discord.com/api/download?platform=osx" /tmp/discord.dmg
hdiutil attach /tmp/discord.dmg -mountPoint /Volumes/discord -noautoopen
# handle autoopen issues
osascript -e 'tell application "Terminal" to activate' 2>/dev/null || true ;
# must be admin user to install:
ls -lap /Volumes/discord/
pkgbuild --analyze --root /Volumes/discord/ --filter Applications --filter .DS_Store --filter .background --filter .fseventsd --filter ._.DS_Store --filter ./.Icon --filter ./._Icon --identifier com.hnc.Discord /tmp/discord_components.plist
pkgbuild --root /Volumes/discord/ --install-location /System/Volumes/Data/Applications/ --filter Applications --filter .DS_Store --filter .background --filter .fseventsd --filter ._.DS_Store --filter .Icon --filter ./._ --identifier com.hnc.Discord --component-plist /tmp/discord_components.plist /tmp/discord_installer.pkg
wait ; sync ; wait ;
hdiutil detach /Volumes/discord || hdiutil detach /Volumes/discord -force ; wait ;
#lsbom `pkgutil --bom /tmp/discord_installer.pkg` || true ;
#head -n 600 /tmp/discord_components.plist || true ;
rm -f /tmp/discord_components.plist ; wait ;
sudo installer -store -pkg /tmp/discord_installer.pkg -target LocalSystem -lang en || true ;
rm -f /tmp/discord_installer.pkg || true ; wait ;
rm -f /tmp/discord.dmg || true ; wait ;
fi

