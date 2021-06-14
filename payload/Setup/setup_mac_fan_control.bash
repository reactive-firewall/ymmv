#! /bin/bash

hash -p $(dirname $0)/../bin/sud sud)

if [[ !( -r ~/Downloads/macsfancontrol.zip ) ]] ; then
	sud https://crystalidea.com/downloads/macsfancontrol.zip ~/Downloads/macsfancontrol.zip || exit 1 ;
fi ;
wait ;
if [[ ( $(mkdir -m 751 /tmp/stage ; wait ; unzip -q ~/Downloads/macsfancontrol.zip -d /tmp/stage/ ; wait ; codesign -vv -R="anchor apple generic" /tmp/stage/*.app 2>&1 3>&1 | grep -coF "explicit requirement satisfied" 2>/dev/null ; rm -fR /tmp/stage 2>/dev/null ) -gt 0 ) ]] ; then
    echo "valid code signature verified";
    unzip -tq ~/Downloads/macsfancontrol.zip -d /dev/null || exit 2
    echo "download successful";
	mkdir -m 2775 /tmp/mac_fan_cntl/
    unzip -qo ~/Downloads/macsfancontrol.zip -d /tmp/mac_fan_cntl || exit 1
	pkgbuild --analyze --root ~/Downloads/bnet_payload/ --filter Applications --filter .DS_Store --filter .fseventsd --filter ._.DS_Store --filter ./.Icon --filter ./._Icon --identifier ${MFC_APP_ID:-"????"} ~/Downloads/mfc_components.plist
	pkgbuild --root /tmp/mac_fan_cntl/ --install-location /System/Volumes/Data/Applications/Utilities --filter Applications --filter .DS_Store --filter .fseventsd --filter ._.DS_Store --filter .Icon --filter ./._ --identifier ${MFC_APP_ID:-"????"} --component-plist ~/Downloads/mfc_components.plist /tmp/macs_fan_control_installer.pkg
	wait ; sync ; wait ;
	echo "build successful"
	rm -f ~/Downloads/mfc_components.plist ; wait ;
	#pkgutil --payload-files /tmp/macs_fan_control_installer.pkg
	#lsbom `pkgutil --bom /tmp/macs_fan_control_installer.pkg`
	rm -Rf /tmp/mac_fan_cntl/ ; wait ;
	rm -f ~/Downloads/macsfancontrol.zip ; wait ;
	wait ; sync ; wait ;
	echo "ready to install"
	osascript -e "do shell script \"installer -pkg /tmp/macs_fan_control_installer.pkg -target LocalSystem -lang en\" with administrator privileges" || true ;
	rm -f /tmp/macs_fan_control_installer.pkg ; wait ;
    echo "install compleate";
    if [[ ( $( codesign -vv -R="anchor apple generic" /Applications/Utilities/"Macs Fan Control.app" 2>&1 3>&1 | grep -coF "explicit requirement satisfied" 2>/dev/null ; wait ) -gt 0 ) ]] ; then
        echo "install successful" ;
    else
		echo "install failed" ;
    fi
fi
exit 0 ;
