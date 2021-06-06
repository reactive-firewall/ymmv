#! /bin/bash

if [[ $( \uname -s ) == "Darwin" ]] ; then
#sudo softwareupdate --install --recommended || true

hash -p $(dirname $0)/../bin/sud sud

# this takes some time:
sud https://cdn.akamai.steamstatic.com/client/installer/steam.dmg /tmp/steam.dmg || exit 1 ;
# must be admin user to install:
wait ; sync ; wait ;
hdiutil attach /tmp/steam.dmg -mountPoint /Volumes/steam -noautoopen
# must be admin user to install:
pkgutil --check-signature /Volumes/steam/Steam.app ;
#ls -lap /Volumes/steam/
pkgbuild --analyze --root /Volumes/steam/ --filter Applications --filter .DS_Store --filter .background --filter .fseventsd --filter ._.DS_Store --filter ./.Icon --filter ./._Icon --identifier com.valvesoftware.steam /tmp/steam_components.plist
pkgbuild --root /Volumes/steam/ --install-location /System/Volumes/Data/Applications/ --filter Applications --filter .DS_Store --filter .background --filter .fseventsd --filter ._.DS_Store --filter .Icon --filter ./._ --identifier com.valvesoftware.steam --component-plist /tmp/steam_components.plist /tmp/steam_installer.pkg
wait ; sync ; wait ;
hdiutil detach /Volumes/steam || hdiutil detach /Volumes/steam -force ; wait ;
rm -f /tmp/steam_components.plist ; wait ;
osascript -e "do shell script \"installer -pkg /tmp/steam_installer.pkg -target LocalSystem -lang en\" with administrator privileges" || true ;
rm -f /tmp/steam_installer.pkg ; wait ;
rm -f /tmp/steam.dmg ; wait ;
if [[ ( $( codesign --verify --verbose=2 -R="anchor apple generic" --check-notarization /Applications/"Steam.app" 2>&1 3>&1 | grep -coF "explicit requirement satisfied" 2>/dev/null ; wait ) -gt 0 ) ]] ; then
	echo "install successful" ;
else
	echo "install failed" ;
	exit 3 ;
fi
fi

