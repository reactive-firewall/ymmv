#! /bin/bash

if [[ $( \uname -s ) == "Darwin" ]] ; then
#sudo softwareupdate --install --recommended || true
hash -p $(dirname $0)/../bin/sud sud
#hash -p $(dirname $0)/../bin/applist.bash applist.bash

echo "looking up latest version"
#_TEMP_SONIC_LINEUP_BNDL_VERSION=$(grep -F "version" /tmp/catalog.yml | tr -s ' ' '\n' | tail -n 1 ) ;
_TEMP_SONIC_LINEUP_BNDL_VERSION=1.1 ;
#rm -f /tmp/catalog.yml 2>/dev/null || true

# this takes some time:
sud "https://code.soundsoftware.ac.uk/attachments/download/2768/Sonic%20Lineup-${_TEMP_SONIC_LINEUP_BNDL_VERSION}.dmg" /tmp/Sonic_Lineup.dmg || exit 1 ;
# must be admin user to install:
wait ; sync ; wait ;
hdiutil attach /tmp/Sonic_Lineup.dmg -mountPoint /Volumes/Sonic_Lineup -noautoopen
# must be admin user to install:
pkgutil --check-signature /Volumes/Sonic_Lineup/"Sonic Lineup.app" ;
#ls -lap /Volumes/Sonic_Lineup/ ;
_TEMP_SONIC_LINEUP_IDENTIFIER=$(plutil -convert json /Volumes/Sonic_Lineup/"Sonic Lineup.app"/Contents/Info.plist -o - | tr -s ',' '\n' | grep -F "CFBundleIdentifier" | tr -s ': ' '\n' | tail -n 1)
echo "${_TEMP_SONIC_LINEUP_IDENTIFIER}"
pkgbuild --analyze --root /Volumes/Sonic_Lineup --filter Applications --filter .DS_Store --filter .background --filter .fseventsd --filter ._.DS_Store --filter ./.Icon --filter "./*.txt" --filter ./._Icon --identifier ${_TEMP_SONIC_LINEUP_IDENTIFIER} --version ${_TEMP_SONIC_LINEUP_BNDL_VERSION} /tmp/sonic_lineup_components.plist
pkgbuild --root /Volumes/Sonic_Lineup --install-location /System/Volumes/Data/Applications/ --filter Applications --filter .DS_Store --filter .background --filter .fseventsd --filter ._.DS_Store --filter .Icon --filter "./*.txt" --filter ./._ --identifier ${_TEMP_SONIC_LINEUP_IDENTIFIER} --version ${_TEMP_SONIC_LINEUP_BNDL_VERSION} --component-plist /tmp/sonic_lineup_components.plist /tmp/sonic_lineup_installer.pkg
wait ; sync ; wait ;
hdiutil detach /Volumes/Sonic_Lineup 2>/dev/null || hdiutil detach /Volumes/Sonic_Lineup -force ; wait ;
rm -f /tmp/sonic_lineup_components.plist ; wait ;
osascript -e "do shell script \"installer -pkg /tmp/sonic_lineup_installer.pkg -target LocalSystem -lang en\" with administrator privileges" || true ;
rm -f /tmp/sonic_lineup_installer.pkg || true
wait ;
rm -f /tmp/Sonic_Lineup.dmg ; wait ;
if [[ ( $( codesign --verify --deep --verbose=2 -R="anchor apple generic" --check-notarization /Applications/"Sonic Lineup.app" 2>&1 3>&1 | grep -coF "explicit requirement satisfied" 2>/dev/null ; wait ) -gt 0 ) ]] ; then
	echo "Install Successful" ;
else
	rm -vfR /Applications/"Sonic Lineup.app" 2>/dev/null || true ;
	pkgutil --edit-pkg "${_TEMP_SONIC_LINEUP_IDENTIFIER}" --forget 2>/dev/null || true ;
	echo "Install Failed" ;
	exit 3 ;
fi
fi
