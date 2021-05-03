#! /bin/bash

if [[ $( \uname -s ) == "Darwin" ]] ; then
#sudo softwareupdate --install --recommended || true

hash -p $(dirname $0)/../bin/sud sud

# this takes some time:
sud https://cdn.akamai.steamstatic.com/client/installer/steam.dmg /tmp/steam.dmg
hdiutil attach /tmp/steam.dmg -mountPoint /Volumes/steam
# must be admin user to install:
ls -lap /Volumes/steam/
pkgbuild --analyze --root /Volumes/steam/ --filter Applications --filter .DS_Store --filter .background --filter .fseventsd --filter ._.DS_Store --filter ./.Icon --filter ./._Icon --identifier com.valvesoftware.steam /tmp/steam_components.plist
pkgbuild --root /Volumes/steam/ --install-location /System/Volumes/Data/Applications/ --filter Applications --filter .DS_Store --filter .background --filter .fseventsd --filter ._.DS_Store --filter .Icon --filter ./._ --identifier com.valvesoftware.steam --component-plist /tmp/steam_components.plist /tmp/steam_installer.pkg
wait ; sync ; wait ;
hdiutil detach /Volumes/steam || hdiutil detach /Volumes/steam -force ; wait ;
rm -f /tmp/steam_components.plist ; wait ;
sudo installer -store -pkg /tmp/steam_installer.pkg -target LocalSystem -lang en
rm -f /tmp/steam_installer.pkg ; wait ;
rm -f /tmp/steam.dmg ; wait ;
fi

