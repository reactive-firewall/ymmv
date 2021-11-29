#! /bin/bash

if [[ $( \uname -s ) == "Darwin" ]] ; then
#sudo softwareupdate --install --recommended || true
hash -p $(dirname $0)/../bin/sud sud
#hash -p $(dirname $0)/../bin/applist.bash applist.bash

echo "checking catalog"
#sud "https://github.com/RPGLogs/Uploaders-warcraftlogs/releases/download/v$_TEMP_WOW_BNDL_LATEST_STUB/latest-mac.yml" /tmp/catalog.yml 2>/dev/null || exit 1;
#rm -f /tmp/catalog.atom 2>/dev/null || true
#echo "looking up latest version"
#_TEMP_TONY_APP_BNDL_VERSION=$(grep -F "version" /tmp/catalog.yml | tr -s ' ' '\n' | tail -n 1 ) ;
_TEMP_TONY_APP_BNDL_VERSION=2.1.1
#rm -f /tmp/catalog.yml 2>/dev/null || true

# this takes some time:
sud https://code.soundsoftware.ac.uk/attachments/download/2619/Tony-${_TEMP_TONY_APP_BNDL_VERSION}.dmg /tmp/Tony-${_TEMP_TONY_APP_BNDL_VERSION}.dmg || exit 1 ;

# must be admin user to install:
wait ; sync ; wait ;
hdiutil attach /tmp/Tony-${_TEMP_TONY_APP_BNDL_VERSION}.dmg -mountPoint /Volumes/Tony -noautoopen
# must be admin user to install:
pkgutil --check-signature /Volumes/Tony/Tony.app ;
#ls -leap /Volumes/Tony/ ;
_TEMP_TONY_APP_IDENTIFIER=$(cat <(plutil -convert json /Volumes/Tony/Tony.app/Contents/Info.plist -o - | tr -s ',' '\n' | grep -F "CFBundleIdentifier" | tr -s ':' '\n' | tail -n 1))
echo "using ID: ${_TEMP_TONY_APP_IDENTIFIER}"
pkgbuild --analyze --root /Volumes/Tony --filter Applications --filter .DS_Store --filter .background --filter .fseventsd --filter ._.DS_Store --filter ./.Icon --filter ./._Icon --filter ./README.txt --identifier "$_TEMP_TONY_APP_IDENTIFIER" --version ${_TEMP_TONY_APP_BNDL_VERSION} /tmp/tony_app_components.plist ;
pkgbuild --root /Volumes/Tony --install-location /System/Volumes/Data/Applications/ --filter Applications --filter .DS_Store --filter .background --filter .fseventsd --filter ._.DS_Store --filter "./*.txt" --filter .Icon --filter ./._ --identifier $_TEMP_TONY_APP_IDENTIFIER --version ${_TEMP_TONY_APP_BNDL_VERSION} --component-plist /tmp/tony_app_components.plist /tmp/tony_app_installer.pkg
pkgutil --payload-files /tmp/tony_app_installer.pkg || true
wait ; sync ; wait ;
hdiutil detach /Volumes/Tony 2>/dev/null || hdiutil detach /Volumes/Tony -force ; wait ;
#plutil -p /tmp/tony_app_components.plist ;
rm -f /tmp/tony_app_components.plist ; wait ;
osascript -e "do shell script \"installer -pkg /tmp/tony_app_installer.pkg -target LocalSystem -lang en\" with administrator privileges" || true ;
rm -f /tmp/tony_app_installer.pkg || true
wait ;
rm -f /tmp/Tony-${_TEMP_TONY_APP_BNDL_VERSION}.dmg ; wait ;
if [[ ( $( codesign --verify --deep --verbose=2 -R="anchor apple generic" --check-notarization /Applications/Tony.app 2>&1 3>&1 | grep -coF "explicit requirement satisfied" 2>/dev/null ; wait ) -gt 0 ) ]] ; then
	echo "Install Successful" ;
else
	rm -vfR /Applications/Tony.app 2>/dev/null || true ;
	echo "Install Failed" ;
	exit 3 ;
fi
fi
