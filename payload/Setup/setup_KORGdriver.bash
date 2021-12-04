#! /bin/bash

if [[ $( \uname -s ) == "Darwin" ]] ; then
#sudo softwareupdate --install --recommended || true
_TEMP_KontrolEditor_BNDL_VERSION=1.8.0
hash -p $(dirname $0)/../bin/sud sud
#hash -p $(dirname $0)/../bin/applist.bash applist.bash

# this takes some time:
sud "https://cdn.korg.com/us/support/download/files/903349f1af1806b409caeb365163fc30.dmg?response-content-disposition=attachment%3Bfilename%2A%3DUTF-8%27%27KontrolEditor_0180.dmg&response-content-type=application%2Foctet-stream%3B" /tmp/KontrolEditor_0180.dmg || exit 1 ;
sud "https://cdn.korg.com/us/support/download/files/02c98003c912cd9601ac47427ddc22f1.dmg?response-content-disposition=attachment%3Bfilename%2A%3DUTF-8%27%27nanoKONTROL2_CSPlugIn_0101.dmg&response-content-type=application%2Foctet-stream%3B" /tmp/nanoKONTROL2_CSPlugIn_0101.dmg || exit 1 ;

# must be admin user to install:
wait ; sync ; wait ;
hdiutil attach /tmp/nanoKONTROL2_CSPlugIn_0101.dmg -mountPoint /Volumes/"nanoKONTROL2 Control Surface plug-in" -noautoopen
cp -vfpr /Volumes/"nanoKONTROL2 Control Surface plug-in"/"nanoKONTROL2 CSPlugIn.pkg" /tmp/"nanoKONTROL2-CSPlugIn.pkg"
hdiutil detach /Volumes/"nanoKONTROL2 Control Surface plug-in" || hdiutil detach /Volumes/"nanoKONTROL2 Control Surface plug-in" -force ; wait ;
wait ; sync ; wait ;
hdiutil attach /tmp/KontrolEditor-0180.dmg -mountPoint /Volumes/KontrolEditor-desktop-mac -noautoopen
# must be admin user to install:
pkgutil --check-signature /Volumes/KontrolEditor-desktop-mac/"KORG KONTROL Editor"/"KORG KONTROL Editor.app" ;
pkgutil --check-signature /tmp/"nanoKONTROL2-CSPlugIn.pkg" ;
# ls -lap /Volumes/KontrolEditor-desktop-mac/ ;
pkgbuild --analyze --root /Volumes/KontrolEditor-desktop-mac/ --filter Applications --filter .DS_Store --filter .background --filter .fseventsd --filter ._.DS_Store --filter ./.Icon --filter ./._Icon --identifier jp.co.korg.kontrol_editor.pkg --version ${_TEMP_KontrolEditor_BNDL_VERSION} /tmp/KontrolEditor_components.plist
pkgbuild --root /Volumes/KontrolEditor-desktop-mac/ --install-location /System/Volumes/Data/Applications --filter Applications --filter .DS_Store --filter .background --filter .fseventsd --filter ._.DS_Store --filter .Icon --filter ./._ --identifier jp.co.korg.kontrol_editor.pkg --version ${_TEMP_KontrolEditor_BNDL_VERSION} --component-plist /tmp/KontrolEditor_components.plist /tmp/KontrolEditor_installer.pkg
wait ; sync ; wait ;
rm -f /tmp/KontrolEditor_components.plist ; wait ;
hdiutil detach /Volumes/KontrolEditor-desktop-mac || hdiutil detach /Volumes/KontrolEditor-desktop-mac -force ; wait ;
osascript -e "do shell script \"installer -pkg /tmp/KontrolEditor_installer.pkg -target LocalSystem -lang en ; wait ; installer -pkg /tmp/nanoKONTROL2-CSPlugIn.pkg -target LocalSystem -lang en\" with administrator privileges" || true ;
rm -f /tmp/KontrolEditor_installer.pkg ; wait ;
rm -f /tmp/KontrolEditor-0180.dmg ; wait ;
rm -f /tmp/nanoKONTROL2-CSPlugIn.pkg ; wait ;
if [[ ( $( codesign --verify --verbose=2 --deep -R="anchor apple generic" --check-notarization /Applications/"KORG KONTROL Editor"/"KORG KONTROL Editor.app" 2>&1 3>&1 | grep -coF "explicit requirement satisfied" 2>/dev/null ; wait ) -gt 0 ) ]] ; then
	echo "Install Successful" ;
else
	echo "Install Failed" ;
	exit 3 ;
fi
fi
