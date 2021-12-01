#! /bin/bash

hash -p $(dirname $0)/../bin/sud sud

if [[ !( -r ~/Downloads/lghub_installer.zip ) ]] ; then
	sud https://download01.logi.com/web/ftp/pub/techsupport/gaming/lghub_installer.zip ~/Downloads/lghub_installer.zip || exit 1 ;
fi ;
wait ;
if [[ ( $(mkdir -m 751 /tmp/stage ; wait ; unzip -q ~/Downloads/lghub_installer.zip -d /tmp/stage/ ; wait ; codesign -vv -R="anchor apple generic" /tmp/stage/*.app 2>&1 3>&1 | grep -coF "explicit requirement satisfied" 2>/dev/null ; rm -fR /tmp/stage 2>/dev/null ) -gt 0 ) ]] ; then
    echo "valid code signature verified";
    unzip -tv ~/Downloads/lghub_installer.zip -d /dev/null || exit 2
    echo "download successful";
	mkdir -m 2775 /tmp/lg_hub/
    unzip -qo ~/Downloads/lghub_installer.zip -d /tmp/lg_hub || exit 1
	pkgutil --check-signature /tmp/lg_hub/lghub_installer.app || exit 2 ;
	LGHI_APP_ID=$($(dirname $0)/../bin/applist.bash /tmp/lg_hub/lghub_installer.app)
	echo "${LGHI_APP_ID}"
	#echo "ready to install"
	#open -b com.logi.ghub.installer || true ;
	pkgutil --edit-pkg "${LGHI_APP_ID}" --learn /tmp/lg_hub/lghub_installer.app 2>/dev/null || true ;
	(exec /tmp/lg_hub/lghub_installer.app/Contents/MacOS/lghub_installer 2>/dev/null ) || true ;
	wait ; sync ; wait ;
	#osascript -e "do shell script \"exec /tmp/lg_hub/lghub_installer.app/Contents/MacOS/lghub_installer\" with administrator privileges" || true ;
	rm -Rf /tmp/lg_hub/* 2>/dev/null || true
	wait ; sync ; wait ;
    echo "install compleate";
    if [[ ( $( codesign -vv -R="anchor apple generic" /Applications/lghub.app 2>&1 3>&1 | grep -coF "explicit requirement satisfied" 2>/dev/null ; wait ) -gt 0 ) ]] ; then
		LGH_APP_ID=$($(dirname $0)/../bin/applist.bash /Applications/lghub.app)
		pkgbuild --component /Applications/lghub.app --install-location /Applications/ --identifier ${LGH_APP_ID} /tmp/lghub_installer.pkg
		wait ; sync ; wait ;
		echo "build successful"
		#pkgutil --payload-files /tmp/lghub_installer.pkg
		#lsbom `pkgutil --bom /tmp/lghub_installer.pkg`
		rm -f ~/Downloads/lghub_installer.zip ; wait ;
		wait ; sync ; wait ;
		echo "ready to reinstall"
		osascript -e "do shell script \"installer -pkg /tmp/lghub_installer.pkg -target LocalSystem -lang en\" with administrator privileges" || true ;
		rm -f /tmp/macs_fan_control_installer.pkg ; wait ;
		pkgutil --edit-pkg "${LGH_APP_ID}" --learn /Applications/lghub.app || exit 3 ;
        echo "install successful" ;
    else
		echo "install failed" ;
    fi
fi
exit 0 ;
