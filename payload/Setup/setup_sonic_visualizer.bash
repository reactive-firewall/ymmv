#! /bin/bash

if [[ $( \uname -s ) == "Darwin" ]] ; then
#sudo softwareupdate --install --recommended || true
hash -p $(dirname $0)/../bin/sud sud
#hash -p $(dirname $0)/../bin/applist.bash applist.bash

echo "looking up latest version"
#_TEMP_SONIC_VISUALISER_BNDL_VERSION=$(grep -F "version" /tmp/catalog.yml | tr -s ' ' '\n' | tail -n 1 ) ;
_TEMP_SONIC_VISUALISER_BNDL_VERSION=4.4 ;
#rm -f /tmp/catalog.yml 2>/dev/null || true

# this takes some time:
sud "https://code.soundsoftware.ac.uk/attachments/download/2813/Sonic%20Visualiser-${_TEMP_SONIC_VISUALISER_BNDL_VERSION}.dmg" /tmp/Sonic_Visualiser.dmg || exit 1 ;
# must be admin user to install:
wait ; sync ; wait ;
hdiutil attach /tmp/Sonic_Visualiser.dmg -mountPoint /Volumes/Sonic_Visualiser -noautoopen
# must be admin user to install:
pkgutil --check-signature /Volumes/Sonic_Visualiser/"Sonic Visualiser.app" ;
#ls -lap /Volumes/Sonic_Visualiser/ ;
_TEMP_SONIC_VISUALISER_IDENTIFIER=$(plutil -convert json /Volumes/Sonic_Visualiser/"Sonic Visualiser.app"/Contents/Info.plist -o - | tr -s ',' '\n' | grep -F "CFBundleIdentifier" | tr -s ': ' '\n' | tail -n 1)
echo "${_TEMP_SONIC_VISUALISER_IDENTIFIER}"
pkgbuild --analyze --root /Volumes/Sonic_Visualiser --filter Applications --filter .DS_Store --filter .background --filter .fseventsd --filter ._.DS_Store --filter ./.Icon --filter "./*.txt" --filter ./._Icon --identifier ${_TEMP_SONIC_VISUALISER_IDENTIFIER} --version ${_TEMP_SONIC_VISUALISER_BNDL_VERSION} /tmp/sonic_Visualiser_components.plist
pkgbuild --root /Volumes/Sonic_Visualiser --install-location /System/Volumes/Data/Applications/ --filter Applications --filter .DS_Store --filter .background --filter .fseventsd --filter ._.DS_Store --filter .Icon --filter "./*.txt" --filter ./._ --identifier ${_TEMP_SONIC_VISUALISER_IDENTIFIER} --version ${_TEMP_SONIC_VISUALISER_BNDL_VERSION} --component-plist /tmp/sonic_Visualiser_components.plist /tmp/sonic_Visualiser_installer.pkg
wait ; sync ; wait ;
hdiutil detach /Volumes/Sonic_Visualiser 2>/dev/null || hdiutil detach /Volumes/Sonic_Visualiser -force ; wait ;
rm -f /tmp/sonic_Visualiser_components.plist ; wait ;
osascript -e "do shell script \"installer -pkg /tmp/sonic_Visualiser_installer.pkg -target LocalSystem -lang en\" with administrator privileges" || true ;
rm -f /tmp/sonic_Visualiser_installer.pkg || true
wait ;
rm -f /tmp/Sonic_Visualiser.dmg ; wait ;
if [[ ( $( codesign --verify --deep --verbose=2 -R="anchor apple generic" --check-notarization /Applications/"Sonic Visualiser.app" 2>&1 3>&1 | grep -coF "explicit requirement satisfied" 2>/dev/null ; wait ) -gt 0 ) ]] ; then
	echo "Install Successful" ;
else
	rm -vfR /Applications/"Sonic Visualiser.app" 2>/dev/null || true ;
	pkgutil --edit-pkg "${_TEMP_SONIC_VISUALISER_IDENTIFIER}" --forget 2>/dev/null || true ;
	echo "Install Failed" ;
	exit 3 ;
fi
fi
