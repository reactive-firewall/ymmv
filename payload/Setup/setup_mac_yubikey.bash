#! /bin/bash

if [[ $( \uname -s ) == "Darwin" ]] ; then
#sudo softwareupdate --install --recommended || true

hash -p $(dirname $0)/../bin/sud sud

# this takes some time:
sud "https://developers.yubico.com/yubikey-manager-qt/Releases/yubikey-manager-qt-1.1.5-mac.pkg" /tmp/yubikey-manager-qt-mac.pkg || exit 1 ;
# must be admin user to install:
wait ; sync ; wait ;
pkgutil --check-signature /tmp/yubikey-manager-qt-mac.pkg || exit 2 ;
#pkgutil --payload-files /tmp/yubikey-manager-qt-mac.pkg
#lsbom `pkgutil --bom /tmp/yubikey-manager-qt-mac.pkg`
wait ; sync ; wait ;
osascript -e "do shell script \"installer -pkg /tmp/yubikey-manager-qt-mac.pkg -target LocalSystem -lang en\" with administrator privileges" || true ;
rm -f /tmp/yubikey-manager-qt-mac.pkg ; wait ;

if [[ ( $( codesign --verify --verbose=2 -R="anchor apple generic" --check-notarization /Applications/"Yubikey Manager.app" 2>&1 3>&1 | grep -coF "explicit requirement satisfied" 2>/dev/null ; wait ) -gt 0 ) ]] ; then
	echo "install successful" ;
else
	echo "install failed" ;
	exit 3 ;
fi
fi
exit 0 ;