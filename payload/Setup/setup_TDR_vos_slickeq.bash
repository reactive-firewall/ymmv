#! /bin/bash

if [[ $( \uname -s ) == "Darwin" ]] ; then
#sudo softwareupdate --install --recommended || true

# SEE official site https://www.tokyodawn.net/tdr-vos-slickeq/

hash -p $(dirname $0)/../bin/sud sud

# this takes some time:
if [[ !( -f ~/Downloads/TDR_VOS_SlickEQ.zip ) ]] ; then
	sud https://www.tokyodawn.net/labs/SlickEQ/1.3.6/TDR%20VOS%20SlickEQ.zip ~/Downloads/TDR_VOS_SlickEQ.zip
fi
if [[ ( $(mkdir -m 755 ~/Downloads/stage ; wait ; unzip -q ~/Downloads/TDR_VOS_SlickEQ.zip -d ~/Downloads/stage/ ; wait ; pkgutil --check-signature ~/Downloads/stage/"TDR VOS SlickEQ.pkg" 2>&1 3>&1 | grep -coF "trusted" 2>/dev/null ; rm -fR ~/Downloads/stage 2>/dev/null ) -gt 0 ) ]] ; then
    echo "valid code signature";
    unzip -tq ~/Downloads/TDR_VOS_SlickEQ.zip -d /dev/null || exit 2
    echo "download successful";
    mkdir -m 755 ~/Downloads/VOS_SlickEQ_payload/ ;
    unzip -qo ~/Downloads/TDR_VOS_SlickEQ.zip -d ~/Downloads/VOS_SlickEQ_payload || exit 1
	find ~/Downloads/VOS_SlickEQ_payload/ -type d -print0 | xargs -0 -L1 -I{} chmod o+rx {} ; wait ;
	find ~/Downloads/VOS_SlickEQ_payload/ -type f -print0 | xargs -0 -L1 -I{} chmod o+r {} ; wait ;
	find ~/Downloads/VOS_SlickEQ_payload/ -iname "TDR VOS SlickEQ.pkg" -type f -print0 | xargs -0 -L1 -I{} chmod 755 {} ; wait ;
else
	exit 2 ;
fi
# must be admin user to install:
#ls -lap ~/Downloads/VOS_SlickEQ_payload/
wait ; sync ; wait ;
#pkgutil --payload-files ~/Downloads/VOS_SlickEQ_payload/"TDR VOS SlickEQ.pkg"
#lsbom `pkgutil --bom ~/Downloads/VOS_SlickEQ_payload/"TDR VOS SlickEQ.pkg"`
rm -f ~/Downloads/TDR_VOS_SlickEQ.zip ; wait ;
mv -vf ~/Downloads/VOS_SlickEQ_payload/"TDR VOS SlickEQ.pkg" /tmp/TDR_VOS_SlickEQ.pkg
rm -fR ~/Downloads/VOS_SlickEQ_payload/ ; wait ;
wait ; sync ; wait ;
osascript -e "do shell script \"installer -pkg /tmp/TDR_VOS_SlickEQ.pkg -target LocalSystem -lang en\" with administrator privileges" || true ;
rm -f /tmp/TDR_VOS_SlickEQ.pkg ; wait ;

if [[ ( $( codesign --verify --verbose=2 -R="anchor apple generic" --check-notarization /Library/Audio/Plug-Ins/Components/"TDR VOS SlickEQ.component" 2>&1 3>&1 | grep -coF "explicit requirement satisfied" 2>/dev/null ; wait ) -gt 0 ) ]] ; then
	echo "install successful" ;
else
	echo "install failed" ;
	exit 3 ;
fi
fi
