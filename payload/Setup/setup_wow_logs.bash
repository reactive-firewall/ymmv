#! /bin/bash

if [[ $( \uname -s ) == "Darwin" ]] ; then
#sudo softwareupdate --install --recommended || true
hash -p $(dirname $0)/../bin/sud sud
#hash -p $(dirname $0)/../bin/applist.bash applist.bash

echo "checking catalog"
sud 'https://github.com/RPGLogs/Uploaders-warcraftlogs/releases.atom' /tmp/catalog.atom 2>/dev/null 1>/dev/null || exit 1;
_TEMP_WOW_BNDL_LATEST_STUB=$(grep -F "https://github.com/RPGLogs/Uploaders-warcraftlogs/releases/tag/" /tmp/catalog.atom 2>/dev/null | head -n 1 | grep -oE "(\d+[.]?)+") ;
sud "https://github.com/RPGLogs/Uploaders-warcraftlogs/releases/download/v$_TEMP_WOW_BNDL_LATEST_STUB/latest-mac.yml" /tmp/catalog.yml 2>/dev/null || exit 1;
rm -f /tmp/catalog.atom 2>/dev/null || true
echo "looking up latest version"
_TEMP_WOW_LOGS_BNDL_VERSION=$(grep -F "version" /tmp/catalog.yml | tr -s ' ' '\n' | tail -n 1 ) ;
rm -f /tmp/catalog.yml 2>/dev/null || true

# this takes some time:
sud https://github.com/RPGLogs/Uploaders-warcraftlogs/releases/download/v${_TEMP_WOW_LOGS_BNDL_VERSION}/Warcraft-Logs-Uploader-${_TEMP_WOW_LOGS_BNDL_VERSION}-universal.dmg /tmp/Warcraft-Logs-Uploader.dmg || exit 1 ;

# must be admin user to install:
wait ; sync ; wait ;
hdiutil attach /tmp/Warcraft-Logs-Uploader.dmg -mountPoint /Volumes/Warcraft-Logs-Uploader -noautoopen
# must be admin user to install:
pkgutil --check-signature /Volumes/Warcraft-Logs-Uploader/"Warcraft Logs Uploader.app" ;
#ls -lap /Volumes/Warcraft-Logs-Uploader/ ;
_TEMP_WOW_LOGS_IDENTIFIER=$(plutil -convert json /Volumes/Warcraft-Logs-Uploader/"Warcraft Logs Uploader.app"/Contents/Info.plist -o - | grep -F "CFBundleIdentifier" | tr -s ' ' '\n' | tail -n 1)
pkgbuild --analyze --root /Volumes/Warcraft-Logs-Uploader --filter Applications --filter .DS_Store --filter .background --filter .fseventsd --filter ._.DS_Store --filter ./.Icon --filter ./._Icon --identifier ${_TEMP_WOW_LOGS_IDENTIFIER} --version ${_TEMP_WOW_LOGS_BNDL_VERSION} /tmp/wow_logs_components.plist
pkgbuild --root /Volumes/Warcraft-Logs-Uploader --install-location /System/Volumes/Data/Applications/ --filter Applications --filter .DS_Store --filter .background --filter .fseventsd --filter ._.DS_Store --filter .Icon --filter ./._ --identifier ${_TEMP_WOW_LOGS_IDENTIFIER} --version ${_TEMP_WOW_LOGS_BNDL_VERSION} --component-plist /tmp/wow_logs_components.plist /tmp/wow_logs_installer.pkg
wait ; sync ; wait ;
hdiutil detach /Volumes/Warcraft-Logs-Uploader 2>/dev/null || hdiutil detach /Volumes/Warcraft-Logs-Uploader -force ; wait ;
rm -f /tmp/wow_logs_components.plist ; wait ;
osascript -e "do shell script \"installer -pkg /tmp/wow_logs_installer.pkg -target LocalSystem -lang en\" with administrator privileges" || true ;
rm -f /tmp/wow_logs_installer.pkg || true
wait ;
rm -f /tmp/Warcraft-Logs-Uploader.dmg ; wait ;
if [[ ( $( codesign --verify --deep --verbose=2 -R="anchor apple generic" --check-notarization /Applications/"Warcraft Logs Uploader.app" 2>&1 3>&1 | grep -coF "explicit requirement satisfied" 2>/dev/null ; wait ) -gt 0 ) ]] ; then
	echo "Install Successful" ;
else
	rm -vfR /Applications/"Warcraft Logs Uploader.app" 2>/dev/null || true ;
	echo "Install Failed" ;
	exit 3 ;
fi
fi
