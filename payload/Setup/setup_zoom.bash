#! /bin/bash

if [[ $( \uname -s ) == "Darwin" ]] ; then
#sudo softwareupdate --install --recommended || true

hash -p $(dirname $0)/../bin/sud sud

# this takes some time:
sud "https://zoom.us/client/latest/ZoomInstallerIT.pkg" /tmp/ZoomInstallerIT.pkg
# must be admin user to install:
wait ; sync ; wait ;
pkgutil --check-signature /tmp/ZoomInstallerIT.pkg || true ;
#pkgutil --payload-files /tmp/ZoomInstallerIT.pkg
#lsbom `pkgutil --bom /tmp/ZoomInstallerIT.pkg`
wait ; sync ; wait ;
mkdir -m 755 ~/Applications/ 2>/dev/null || true ;
osascript -e "do shell script \"installer -pkg /tmp/ZoomInstallerIT.pkg -target LocalSystem -lang en && pkgutil --files us.zoom.pkg.videmeeting | xargs -L1 -I{} mv -vf \\\"/Applications/{}\\\" \\\"${HOME}/Applications/{}\\\"\" with administrator privileges" || true ;
rm -f /tmp/ZoomInstallerIT.pkg ; wait ;

if [[ ( $( codesign -vv -R="anchor apple generic" ~/Applications/"zoom.us.app" 2>&1 3>&1 | grep -coF "explicit requirement satisfied" 2>/dev/null ; wait ) -gt 0 ) ]] ; then
	echo "install successful" ;
else
	echo "install failed" ;
fi
fi

