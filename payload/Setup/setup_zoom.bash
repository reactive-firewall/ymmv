#! /bin/bash

if [[ $( \uname -s ) == "Darwin" ]] ; then
#sudo softwareupdate --install --recommended || true

hash -p $(dirname $0)/../bin/sud sud

# this takes some time:
sud "https://zoom.us/client/latest/ZoomInstallerIT.pkg" /tmp/ZoomInstallerIT.pkg || exit 1 ;
# must be admin user to install:
wait ; sync ; wait ;
pkgutil --check-signature /tmp/ZoomInstallerIT.pkg || exit 2 ;
#pkgutil --payload-files /tmp/ZoomInstallerIT.pkg
#lsbom `pkgutil --bom /tmp/ZoomInstallerIT.pkg`
wait ; sync ; wait ;
mkdir -m 755 ~/Applications/ 2>/dev/null || true ;
osascript -e "do shell script \"installer -pkg /tmp/ZoomInstallerIT.pkg -target LocalSystem -lang en && pkgutil --files us.zoom.pkg.videmeeting | xargs -L1 -I{} mv -vf \\\"/Applications/{}\\\" \\\"${HOME}/Applications/{}\\\"\" with administrator privileges" || true ;
rm -f /tmp/ZoomInstallerIT.pkg ; wait ;

mkdir -m 751 ~/Movies/Zoom 2>/dev/null || true ;
defaults write us.zoom.xos NSNavLastRootDirectory -string "~/Movies/Zoom" 2>/dev/null || true
defaults write us.zoom.xos "User Select Language Identify" -string en 2>/dev/null || true ;
defaults write us.zoom.xos kCaptureWithoutChatWindow -bool YES 2>/dev/null || true ;
defaults write us.zoom.xos kZMUserDefaultSelectedTabType -int 0
defaults write us.zoom.xos "s_skinToneNum" -int 1

for DISABLE_KEY in NSQuitAlwaysKeepsWindows kZMSettingVBHaveGreenScreen kZMUserDefaultMainWindowCompressed ; do
		defaults write us.zoom.xos ${DISABLE_KEY} -bool NO 2>/dev/null || true ;
done ;

if [[ ( $( codesign --verify --verbose=2 -R="anchor apple generic" --check-notarization ~/Applications/"zoom.us.app" 2>&1 3>&1 | grep -coF "explicit requirement satisfied" 2>/dev/null ; wait ) -gt 0 ) ]] ; then
	echo "install successful" ;
else
	echo "install failed" ;
	rm -fR ~/us.zoom.app 2>/dev/null || true
	defaults delete us.zoom.xos 2>/dev/null || true ;
	defaults delete ZoomChat 2>/dev/null || true ;
	exit 3 ;
fi
fi

