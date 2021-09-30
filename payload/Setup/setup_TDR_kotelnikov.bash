#! /bin/bash

if [[ $( \uname -s ) == "Darwin" ]] ; then
#sudo softwareupdate --install --recommended || true

# SEE official site https://www.tokyodawn.net/tdr-kotelnikov

hash -p $(dirname $0)/../bin/sud sud

# this takes some time:
if [[ !( -f ~/Downloads/TDR_Kotelnikov.zip ) ]] ; then
	sud https://www.tokyodawn.net/labs/Kotelnikov/1.6.3/TDR%20Kotelnikov.zip ~/Downloads/TDR_Kotelnikov.zip
fi
if [[ ( $(mkdir -m 755 ~/Downloads/stage ; wait ; unzip -q ~/Downloads/TDR_Kotelnikov.zip -d ~/Downloads/stage/ ; wait ; pkgutil --check-signature ~/Downloads/stage/"TDR Kotelnikov.pkg" 2>&1 3>&1 | grep -coF "trusted" 2>/dev/null ; rm -fR ~/Downloads/stage 2>/dev/null ) -gt 0 ) ]] ; then
    echo "valid code signature";
    unzip -tq ~/Downloads/TDR_Kotelnikov.zip -d /dev/null || exit 2
    echo "download successful";
    mkdir -m 755 ~/Downloads/Kotelnikov_payload/ ;
    unzip -qo ~/Downloads/TDR_Kotelnikov.zip -d ~/Downloads/Kotelnikov_payload || exit 1
	find ~/Downloads/Kotelnikov_payload/ -type d -print0 | xargs -0 -L1 -I{} chmod o+rx {} ; wait ;
	find ~/Downloads/Kotelnikov_payload/ -type f -print0 | xargs -0 -L1 -I{} chmod o+r {} ; wait ;
	find ~/Downloads/Kotelnikov_payload/ -iname "TDR Kotelnikov.pkg" -type f -print0 | xargs -0 -L1 -I{} chmod 755 {} ; wait ;
else
	exit 2 ;
fi
# must be admin user to install:
#ls -lap ~/Downloads/Kotelnikov_payload/
wait ; sync ; wait ;
#pkgutil --payload-files ~/Downloads/Kotelnikov_payload/"TDR Kotelnikov.pkg"
#lsbom `pkgutil --bom ~/Downloads/Kotelnikov_payload/"TDR Kotelnikov.pkg"`
rm -f ~/Downloads/TDR_Kotelnikov.zip ; wait ;
mv -vf ~/Downloads/Kotelnikov_payload/"TDR Kotelnikov.pkg" /tmp/TDR_Kotelnikov.pkg
rm -fR ~/Downloads/Kotelnikov_payload/ ; wait ;
wait ; sync ; wait ;
osascript -e "do shell script \"installer -pkg /tmp/TDR_Kotelnikov.pkg -target LocalSystem -lang en\" with administrator privileges" || true ;
rm -f /tmp/TDR_Kotelnikov.pkg ; wait ;

if [[ ( $( codesign --verify --verbose=2 -R="anchor apple generic" --check-notarization /Library/Audio/Plug-Ins/Components/"TDR Kotelnikov.component" 2>&1 3>&1 | grep -coF "explicit requirement satisfied" 2>/dev/null ; wait ) -gt 0 ) ]] ; then
	echo "install successful" ;
else
	echo "install failed" ;
	exit 3 ;
fi
fi
