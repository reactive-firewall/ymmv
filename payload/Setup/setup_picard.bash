#! /bin/bash

if [[ $( \uname -s ) == "Darwin" ]] ; then
#sudo softwareupdate --install --recommended || true
_TEMP_MusicBrainz_Picard_BNDL_VERSION=2.6.3
hash -p $(dirname $0)/../bin/sud sud
#hash -p $(dirname $0)/../bin/applist.bash applist.bash

# this takes some time:
sud https://musicbrainz.osuosl.org/pub/musicbrainz/picard/MusicBrainz-Picard-${_TEMP_MusicBrainz_Picard_BNDL_VERSION}-macOS-10.14.dmg /tmp/MusicBrainz-Picard-desktop-mac.dmg || exit 1 ;
# must be admin user to install:
wait ; sync ; wait ;
hdiutil attach /tmp/MusicBrainz-Picard-desktop-mac.dmg -mountPoint /Volumes/MusicBrainz-Picard-desktop-mac -noautoopen
# must be admin user to install:
pkgutil --check-signature /Volumes/MusicBrainz-Picard-desktop-mac/"MusicBrainz Picard.app" ;
# ls -lap /Volumes/MusicBrainz-Picard-desktop-mac/ ;
pkgbuild --analyze --root /Volumes/MusicBrainz-Picard-desktop-mac/ --filter Applications --filter .DS_Store --filter .background --filter .fseventsd --filter ._.DS_Store --filter ./.Icon --filter ./._Icon --identifier org.musicbrainz.Picard.pkg --version ${_TEMP_MusicBrainz_Picard_BNDL_VERSION} /tmp/MusicBrainz-Picard_components.plist
pkgbuild --root /Volumes/MusicBrainz-Picard-desktop-mac/ --install-location /System/Volumes/Data/Applications/ --filter Applications --filter .DS_Store --filter .background --filter .fseventsd --filter ._.DS_Store --filter .Icon --filter ./._ --identifier org.musicbrainz.Picard.pkg --version ${_TEMP_MusicBrainz_Picard_BNDL_VERSION} --component-plist /tmp/MusicBrainz-Picard_components.plist /tmp/MusicBrainz-Picard_installer.pkg
wait ; sync ; wait ;
hdiutil detach /Volumes/MusicBrainz-Picard-desktop-mac || hdiutil detach /Volumes/MusicBrainz-Picard-desktop-mac -force ; wait ;
rm -f /tmp/MusicBrainz-Picard_components.plist ; wait ;
osascript -e "do shell script \"installer -pkg /tmp/MusicBrainz-Picard_installer.pkg -target LocalSystem -lang en\" with administrator privileges" || true ;
rm -f /tmp/MusicBrainz-Picard_installer.pkg ; wait ;
rm -f /tmp/MusicBrainz-Picard-desktop-mac.dmg ; wait ;
if [[ ( $( codesign --verify --verbose=2 -R="anchor apple generic" --check-notarization /Applications/"MusicBrainz Picard.app" 2>&1 3>&1 | grep -coF "explicit requirement satisfied" 2>/dev/null ; wait ) -gt 0 ) ]] ; then
	echo "Install Successful" ;
else
	echo "Install Failed" ;
	exit 3 ;
fi
fi
