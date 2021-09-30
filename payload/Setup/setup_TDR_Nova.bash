#! /bin/bash

if [[ $( \uname -s ) == "Darwin" ]] ; then
#sudo softwareupdate --install --recommended || true

# SEE official site https://www.tokyodawn.net/tdr-nova/

hash -p $(dirname $0)/../bin/sud sud

# this takes some time:
if [[ !( -f ~/Downloads/TDR_Nova.zip ) ]] ; then
	sud https://www.tokyodawn.net/labs/Nova/2.1.4/TDR%20Nova.zip ~/Downloads/TDR_Nova.zip
fi
if [[ ( $(mkdir -m 755 ~/Downloads/stage ; wait ; unzip -q ~/Downloads/TDR_Nova.zip -d ~/Downloads/stage/ ; wait ; pkgutil --check-signature ~/Downloads/stage/"TDR Nova.pkg" 2>&1 3>&1 | grep -coF "trusted" 2>/dev/null ; rm -fR ~/Downloads/stage 2>/dev/null ) -gt 0 ) ]] ; then
    echo "valid code signature";
    unzip -tq ~/Downloads/TDR_Nova.zip -d /dev/null || exit 2
    echo "download successful";
    mkdir -m 755 ~/Downloads/nova_payload/ ;
    unzip -qo ~/Downloads/TDR_Nova.zip -d ~/Downloads/nova_payload || exit 1
	find ~/Downloads/nova_payload/ -type d -print0 | xargs -0 -L1 -I{} chmod o+rx {} ; wait ;
	find ~/Downloads/nova_payload/ -type f -print0 | xargs -0 -L1 -I{} chmod o+r {} ; wait ;
	find ~/Downloads/nova_payload/ -iname "TDR Nova.pkg" -type f -print0 | xargs -0 -L1 -I{} chmod 755 {} ; wait ;
else
	exit 2 ;
fi
# must be admin user to install:
#ls -lap ~/Downloads/nova_payload/
wait ; sync ; wait ;
#pkgutil --payload-files ~/Downloads/nova_payload/"TDR Nova.pkg"
#lsbom `pkgutil --bom ~/Downloads/nova_payload/"TDR Nova.pkg"`
rm -f ~/Downloads/TDR_Nova.zip ; wait ;
mv -vf ~/Downloads/nova_payload/"TDR Nova.pkg" /tmp/TDR_Nova.pkg
rm -fR ~/Downloads/nova_payload/ ; wait ;
wait ; sync ; wait ;
osascript -e "do shell script \"installer -pkg /tmp/TDR_Nova.pkg -target LocalSystem -lang en\" with administrator privileges" || true ;
rm -f /tmp/TDR_Nova.pkg ; wait ;

if [[ ( $( codesign --verify --verbose=2 -R="anchor apple generic" --check-notarization /Library/Audio/Plug-Ins/Components/"TDR Nova.component" 2>&1 3>&1 | grep -coF "explicit requirement satisfied" 2>/dev/null ; wait ) -gt 0 ) ]] ; then
	echo "install successful" ;
else
	echo "install failed" ;
	exit 3 ;
fi
fi
