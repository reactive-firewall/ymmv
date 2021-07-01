#! /bin/bash

if [[ $( \uname -s ) == "Darwin" ]] ; then
#sudo softwareupdate --install --recommended || true
_TEMP_Scarlett_MixControl_BNDL_VERSION=1.10.0
hash -p $(dirname $0)/../bin/sud sud
#hash -p $(dirname $0)/../bin/applist.bash applist.bash

# this takes some time:
sud https://fael-downloads-prod.focusrite.com/customer/prod/s3fs-public/downloads/Scarlett%20MixControl-1.10_0.dmg /tmp/Scarlett-MixControl-desktop-mac.dmg || exit 1 ;

# user guides for 18i20 and 2i2
sud https://fael-downloads-prod.focusrite.com/customer/prod/s3fs-public/focusrite/downloads/8424/scarlett18i20-user-guideeng.pdf ~/Downloads/scarlett18i20-user-guide.pdf || true ;
sud https://fael-downloads-prod.focusrite.com/customer/prod/s3fs-public/downloads/Scarlett%20Mix%20Control%201.10%20for%20Windows%20-%20Release%20Notes.pdf ~/Downloads/scarlett18i20-Release-Notes.pdf || true ;
sud https://fael-downloads-prod.focusrite.com/customer/prod/s3fs-public/downloads/Scarlett%202i2%20Studio%202nd%20Gen%20User%20Guide%20v1.1%20English%20-%20EN.pdf ~/Downloads/scarlett-2i2-user-guide.pdf || true ;

# must be admin user to install:
wait ; sync ; wait ;
hdiutil attach /tmp/Scarlett-MixControl-desktop-mac.dmg -mountPoint /Volumes/Scarlett-MixControl-desktop-mac -noautoopen
# must be admin user to install:
pkgutil --check-signature /Volumes/Scarlett-MixControl-desktop-mac/"Scarlett MixControl.app" ;
# ls -lap /Volumes/Scarlett-MixControl-desktop-mac/ ;
pkgbuild --analyze --root /Volumes/Scarlett-MixControl-desktop-mac/ --filter Applications --filter .DS_Store --filter .background --filter .fseventsd --filter ._.DS_Store --filter ./.Icon --filter ./._Icon --identifier org.musicbrainz.Picard.pkg --version ${_TEMP_Scarlett_MixControl_BNDL_VERSION} /tmp/Scarlett-MixControl_components.plist
pkgbuild --root /Volumes/Scarlett-MixControl-desktop-mac/ --install-location /System/Volumes/Data/Applications --filter Applications --filter .DS_Store --filter .background --filter .fseventsd --filter ._.DS_Store --filter .Icon --filter ./._ --identifier org.musicbrainz.Picard.pkg --version ${_TEMP_Scarlett_MixControl_BNDL_VERSION} --component-plist /tmp/Scarlett-MixControl_components.plist /tmp/Scarlett-MixControl_installer.pkg
wait ; sync ; wait ;
hdiutil detach /Volumes/Scarlett-MixControl-desktop-mac || hdiutil detach /Volumes/Scarlett-MixControl-desktop-mac -force ; wait ;
rm -f /tmp/Scarlett-MixControl_components.plist ; wait ;
osascript -e "do shell script \"installer -pkg /tmp/Scarlett-MixControl_installer.pkg -target LocalSystem -lang en\" with administrator privileges" || true ;
rm -f /tmp/Scarlett-MixControl_installer.pkg ; wait ;
rm -f /tmp/Scarlett-MixControl-desktop-mac.dmg ; wait ;
if [[ ( $( codesign --verify --verbose=2 -R="anchor apple generic" --check-notarization /Applications/"Scarlett MixControl.app" 2>&1 3>&1 | grep -coF "explicit requirement satisfied" 2>/dev/null ; wait ) -gt 0 ) ]] ; then
	echo "Install Successful" ;
else
	echo "Install Failed" ;
	rm -vf ~/Downloads/scarlett18i20-user-guide.pdf 2>/dev/null || true ;
	rm -vf ~/Downloads/scarlett18i20-Release-Notes.pdf 2>/dev/null || true ;
	rm -vf ~/Downloads/scarlett-2i2-user-guide.pdf 2>/dev/null || true ;
	exit 3 ;
fi
fi

