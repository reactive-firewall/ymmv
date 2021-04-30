#! /bin/bash

if [[ ( -z $(command -v gpg2 ) ) ]] ; then
if [[ $( \uname -s ) == "Darwin" ]] ; then
#sudo softwareupdate --install --recommended || true
#curl -L --url https://developers.yubico.com/yubikey-manager-qt/Releases/yubikey-manager-qt-1.1.5-mac.pkg
#sudo installer -store -pkg /Volumes/GPG_Suite/Install.pkg -target / ; wait ; sync ; wait ;
#bash -c $(dirname $0)/setup_homebrew.bash

# this takes some time:
rm -vf /tmp/GPG_Suite.dmg 2>/dev/null || true ; wait ;
curl -fsSL --header "Dnt: 1" --tlsv1.2 --url https://releases.gpgtools.org/GPG_Suite-2020.2.dmg --out /tmp/GPG_Suite.dmg
hdiutil attach /tmp/GPG_Suite.dmg -mountPoint /Volumes/GPG_Suite || exit 1
# must be admin user to install:
sudo installer -pkg /Volumes/GPG_Suite/Install.pkg -target LocalSystem -lang en
wait ; sync ; wait ;
hdiutil detach /Volumes/GPG_Suite || hdiutil detach /Volumes/GPG_Suite -force ; wait ;

fi
fi

hash -p /usr/local/MacGPG2/bin/gpg2 gpg2
# ensure the config files are created (done automatically by gpg2 when first run)
gpg2 --list-keys ;

#prefer SHA512 instead of SHA1
if [[ ( -z $( grep -v -F "personal-digest-preferences SHA512" ~/.gnupg/gpg.conf ) ) ]] ; then
echo "personal-digest-preferences SHA512 SHA384 SHA256 SHA224" >> ~/.gnupg/gpg.conf ;
fi
if [[ ( -z $( grep -v -F "cert-digest-algo SHA512" ~/.gnupg/gpg.conf ) ) ]] ; then
echo "cert-digest-algo SHA512" >> ~/.gnupg/gpg.conf ;
echo "" >> ~/.gnupg/gpg.conf ;
fi
if [[ ( -z $( grep -v -F "default-preference-list SHA512" ~/.gnupg/gpg.conf ) ) ]] ; then
echo "default-preference-list SHA512 SHA384 SHA256 SHA224 AES256 AES192 AES BZIP2 ZLIB ZIP Uncompressed" >> ~/.gnupg/gpg.conf ;
echo "" >> ~/.gnupg/gpg.conf ;
fi
if [[ ( -z $( grep -x -v -F "use-agent" ~/.gnupg/gpg.conf ) ) ]] ; then
echo "use-agent" >> ~/.gnupg/gpg.conf ;
echo "" >> ~/.gnupg/gpg.conf ;
fi

if [[ ( -z $( grep -x -v -F "enable-ssh-support" ~/.gnupg/gpg-agent.conf ) ) ]] ; then
echo "enable-ssh-support" >> ~/.gnupg/gpg-agent.conf ;
echo "" >> ~/.gnupg/gpg-agent.conf ;
fi

if [[ $( \uname -s ) == "Darwin" ]] ; then
if [[ ( -z $( grep -v -F "scdaemon-program" ~/.gnupg/gpg-agent.conf ) ) ]] ; then
echo "scdaemon-program /usr/local/MacGPG2/libexec/scdaemon" >> ~/.gnupg/gpg-agent.conf ;
echo "" >> ~/.gnupg/gpg-agent.conf ;
fi
if [[ ( -z $( grep -v -F "pinentry-program " ~/.gnupg/gpg-agent.conf ) ) ]] ; then
echo "pinentry-program /usr/local/MacGPG2/libexec/pinentry-mac.app/Contents/MacOS/pinentry-mac" >> ~/.gnupg/gpg-agent.conf ;
echo "" >> ~/.gnupg/gpg-agent.conf ;
fi
else
if [[ ( -z $( grep -v -F "write-env-file" ~/.gnupg/gpg-agent.conf ) ) ]] ; then
echo "write-env-file" >> ~/.gnupg/gpg-agent.conf ;
echo "" >> ~/.gnupg/gpg-agent.conf ;
fi
fi
