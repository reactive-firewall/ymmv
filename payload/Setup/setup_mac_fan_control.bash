#! /bin/bash

if [[ !( -r ~/Downloads/macsfancontrol.zip ) ]] ; then
curl -fsSL https://crystalidea.com/downloads/macsfancontrol.zip -o ~/Downloads/macsfancontrol.zip || exit 1 ;
fi ;
wait ;
if [[ ( $(mkdir -m 751 /tmp/stage ; wait ; unzip -q ~/Downloads/macsfancontrol.zip -d /tmp/stage/ ; wait ; codesign -vv -R="anchor apple generic" /tmp/stage/*.app 2>&1 3>&1 | grep -coF "explicit requirement satisfied" 2>/dev/null ; rm -fR /tmp/stage 2>/dev/null ) -gt 0 ) ]] ; then
    echo "valid code signature";
    unzip -tq ~/Downloads/macsfancontrol.zip -d /dev/null || exit 2
    echo "download successful";
    unzip -qo ~/Downloads/macsfancontrol.zip -d /Applications/Utilities/ || exit 1
    echo "install compleate";
    if [[ ( $( codesign -vv -R="anchor apple generic" /Applications/Utilities/"Macs Fan Control.app" 2>&1 3>&1 | grep -coF "explicit requirement satisfied" 2>/dev/null ; wait ) -gt 0 ) ]] ; then
        echo "install successful" ;
    else
	echo "install failed" ;
    fi
fi
exit 0 ;
