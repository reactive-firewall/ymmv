#! /bin/bash

if [[ $( \uname -s ) == "Darwin" ]] ; then
hash -p $(dirname $0)/../bin/sud sud

# this takes some time:
if [[ !( -r /tmp/RemotePlayInstaller.pkg ) ]] ; then
sud "https://remoteplay.dl.playstation.net/remoteplay/module/mac/RemotePlayInstaller.pkg" /tmp/RemotePlayInstaller.pkg || exit 1;
fi
# must be admin user to install:
wait ; sync ; wait ;
pkgutil --check-signature /tmp/RemotePlayInstaller.pkg || exit 2 ;
#pkgutil --payload-files /tmp/RemotePlayInstaller.pkg
#lsbom `pkgutil --bom /tmp/RemotePlayInstaller.pkg`
wait ; sync ; wait ;
osascript -e "do shell script \"installer -pkg /tmp/RemotePlayInstaller.pkg -target LocalSystem -lang en\" with administrator privileges" || true ;
rm -f /tmp/RemotePlayInstaller.pkg ; wait ;

if [[ ( $( codesign --verify --verbose=2 -R="anchor apple generic" --check-notarization /Applications/RemotePlay.app 2>&1 3>&1 | grep -coF "explicit requirement satisfied" 2>/dev/null ; wait ) -gt 0 ) ]] ; then
	echo "install successful" ;
else
	echo "install failed" ;
	defaults delete com.playstation.RemotePlay 2>/dev/null || true ;
	exit 3 ;
fi
fi

exit 0 ;
