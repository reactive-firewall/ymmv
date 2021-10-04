#! /bin/bash

if [[ $( \uname -s ) == "Darwin" ]] ; then
#sudo softwareupdate --install --recommended || true
hash -p $(dirname $0)/../bin/sud sud
#hash -p $(dirname $0)/../bin/applist.bash applist.bash

echo "checking catalog"
sud 'https://updates.signal.org/desktop/latest-mac.yml' /tmp/catalog.yml || exit 1;
_TEMP_SIGNAL_BNDL_VERSION=$(grep -F "version" /tmp/catalog.yml | tr -s ' ' '\n' | tail -n 1 ) ;
rm -f /tmp/catalog.yml 2>/dev/null || true

# this takes some time:
sud https://updates.signal.org/desktop/signal-desktop-mac-${_TEMP_SIGNAL_BNDL_VERSION}.dmg /tmp/signal-desktop-mac.dmg || exit 1 ;
# must be admin user to install:
wait ; sync ; wait ;
hdiutil attach /tmp/signal-desktop-mac.dmg -mountPoint /Volumes/signal-desktop-mac -noautoopen
# must be admin user to install:
pkgutil --check-signature /Volumes/signal-desktop-mac/Signal.app ;
# ls -lap /Volumes/signal-desktop-mac/ ;
pkgbuild --analyze --root /Volumes/signal-desktop-mac/ --filter Applications --filter .DS_Store --filter .background --filter .fseventsd --filter ._.DS_Store --filter ./.Icon --filter ./._Icon --identifier org.whispersystems.signal-desktop --version ${_TEMP_SIGNAL_BNDL_VERSION} /tmp/signal_components.plist
pkgbuild --root /Volumes/signal-desktop-mac/ --install-location /System/Volumes/Data/Applications/ --filter Applications --filter .DS_Store --filter .background --filter .fseventsd --filter ._.DS_Store --filter .Icon --filter ./._ --identifier org.whispersystems.signal-desktop --version ${_TEMP_SIGNAL_BNDL_VERSION} --component-plist /tmp/signal_components.plist /tmp/signal_installer.pkg
wait ; sync ; wait ;
hdiutil detach /Volumes/signal-desktop-mac || hdiutil detach /Volumes/signal-desktop-mac -force ; wait ;
rm -f /tmp/signal_components.plist ; wait ;
osascript -e "do shell script \"installer -pkg /tmp/signal_installer.pkg -target LocalSystem -lang en\" with administrator privileges" || true ;
rm -f /tmp/signal_installer.pkg ; wait ;
rm -f /tmp/signal-desktop-mac.dmg ; wait ;
if [[ ( $( codesign --verify --deep --verbose=2 -R="anchor apple generic" --check-notarization /Applications/"Signal.app" 2>&1 3>&1 | grep -coF "explicit requirement satisfied" 2>/dev/null ; wait ) -gt 0 ) ]] ; then
	echo "Install Successful" ;
else
	echo "Install Failed" ;
	exit 3 ;
fi
fi
