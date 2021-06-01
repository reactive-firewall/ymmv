#! /bin/bash

if [[ $( \uname -s ) == "Darwin" ]] ; then
#sudo softwareupdate --install --recommended || true

hash -p $(dirname $0)/../bin/sud sud

# this takes some time:
sud "https://us.battle.net/download/getInstaller?os=mac&installer=Battle.net-Setup.zip" ~/Downloads/Battle.net-Setup.zip
if [[ ( $(mkdir -m 755 ~/Downloads/stage ; wait ; unzip -q ~/Downloads/Battle.net-Setup.zip -d ~/Downloads/stage/ ; wait ; codesign -vv -R="anchor apple generic" ~/Downloads/stage/"Battle.net-Setup.app" 2>&1 3>&1 | grep -coF "explicit requirement satisfied" 2>/dev/null ; rm -fR ~/Downloads/stage 2>/dev/null ) -gt 0 ) ]] ; then
    echo "valid code signature";
    unzip -tq ~/Downloads/Battle.net-Setup.zip -d /dev/null || exit 2
    echo "download successful";
	mkdir -m 755 ~/Downloads/bnet_payload ; wait ;
    unzip -qo ~/Downloads/Battle.net-Setup.zip -d ~/Downloads/bnet_payload || exit 1
	find ~/Downloads/bnet_payload/ -type d -print0 | xargs -0 -L1 -I{} chmod o+rx {} ; wait ;
	find ~/Downloads/bnet_payload/ -type f -print0 | xargs -0 -L1 -I{} chmod o+r {} ; wait ;
	find ~/Downloads/bnet_payload/ -ipath "*/MacOS/*" -type f -print0 | xargs -0 -L1 -I{} chmod 755 {} ; wait ;
else
	exit 2 ;
fi
# must be admin user to install:
ls -lap ~/Downloads/bnet_payload/
BNET_APP_ID=$($(dirname $0)/../bin/applist.bash ~/Downloads/bnet_payload/"Battle.net-Setup.app")
pkgbuild --analyze --root ~/Downloads/bnet_payload/ --filter Applications --filter .DS_Store --filter .fseventsd --filter ._.DS_Store --filter ./.Icon --filter ./._Icon --identifier ${BNET_APP_ID:-"net.battle.bootstrapper"} ~/Downloads/bnet_components.plist
pkgbuild --root ~/Downloads/bnet_payload/ --install-location /System/Volumes/Data/Applications/ --filter Applications --filter .DS_Store --filter .fseventsd --filter ._.DS_Store --filter .Icon --filter ./._ --identifier net.battle.bootstrapper --component-plist ~/Downloads/bnet_components.plist /tmp/bnet_installer.pkg
wait ; sync ; wait ;
rm -f ~/Downloads/bnet_components.plist ; wait ;
#pkgutil --payload-files ~/Downloads/bnet_installer.pkg
#lsbom `pkgutil --bom ~/Downloads/bnet_installer.pkg`
#less ~/Downloads/bnet_payload/Battle.net-Setup.app/Contents/info.plist
rm -Rf ~/Downloads/bnet_payload/ ; wait ;
rm -f ~/Downloads/Battle.net-Setup.zip ; wait ;
wait ; sync ; wait ;
osascript -e "do shell script \"installer -pkg /tmp/bnet_installer.pkg -target LocalSystem -lang en\" with administrator privileges" || true ;
rm -f /tmp/bnet_installer.pkg ; wait ;
if [[ ( $( codesign -vv -R="anchor apple generic" /Applications/"Battle.net-Setup.app" 2>&1 3>&1 | grep -coF "explicit requirement satisfied" 2>/dev/null ; wait ) -gt 0 ) ]] ; then
	echo "install successful" ;
else
	echo "install failed" ;
fi
fi

