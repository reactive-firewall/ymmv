#! /bin/bash

if [[ $( \uname -s ) == "Darwin" ]] ; then
sudo softwareupdate --install --recommended || true
curl -fsSL --header "Dnt: 1" --tlsv1.2 --url https://developers.yubico.com/yubikey-manager-qt/Releases/yubikey-manager-qt-1.1.5-mac.pkg --out /tmp/yubikey-manager-qt-mac.pkg
sudo installer -store -pkg /tmp/yubikey-manager-qt-mac.pkg -target / ; wait ; sync ; wait ;
wait ; sync ; wait ;
fi