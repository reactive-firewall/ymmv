#! /bin/bash
#########################
# Homebrew Setup
#########################
umask 002
#ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
if [[ !( -e ~/homebrew ) ]] ; then
cd ~/
mkdir homebrew && curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C homebrew
cd ${OLDPWD}
fi
chflags 'hidden' ~/homebrew 2>/dev/null || true ;
source ~/.bashrc
HOMEBREW_USER=$(stat -f %u ~/homebrew/)
HOMEBREW_GROUP=$(stat -f %g ~/homebrew/)
umask 002
export HOMEBREW_CASK_OPTS="--appdir=~/homebrew/Applications/ --fontdir=~/homebrew/Library/Fonts"
brew analytics off
brew update
brew upgrade

##########################
# Tap Homebrew Repos
##########################
brew tap "homebrew/core" || true
brew tap "homebrew/cask" || true

##########################
# set aliases
##########################
rm -rf "$(brew --cache)"

##########################
# Network tools
##########################
brew install "openssl"
brew install "dnstracer"
brew install "nmap"

#########################
# Cloud Apps
#########################
#brew install --cask "google-drive-file-stream"

#########################
# Email / Messaging Apps
#########################
#brew install --cask "slack"
brew install --cask "twitch"

#########################
# Files Apps
#########################
#brew install --cask "send-to-kindle"
#brew install --cask "timemachineeditor"

#########################
# Media Apps
#########################
brew install --cask "max"
brew install --cask "musicbrainz-picard"
brew install --cask "vlc"
brew install --cask "gimp"
brew install --cask "4k-video-downloader"

#########################
# Security Apps
#########################
brew install "libassuan"
brew install "gnu-pkcs11-scd" || true
brew install "libgpg-error"
brew install "pkcs11-helper"
brew install "gpg-suite-pinentry" || true
brew install --cask "opensc" || true

#########################
# Programming Apps
#########################
# brew install --cask "android-file-transfer"
# brew install --cask "bbedit"
# brew install --cask "github"
# brew install --cask "osxfuse"
# brew install --cask "sublime-text"
# brew install --cask "virtualbox"
# brew install --cask "virtualbox-extension-pack"

#########################
# Gaming Apps
#########################
#brew install --cask "battle-net"
#brew install --cask "starcraft"
#brew install --cask "steam"
#brew install --cask "steamcmd"

#########################
# Quick Look Apps
#########################
#brew install --cask "provisionql"
#brew install --cask "qlcolorcode"
brew install --cask "qlimagesize"
brew install --cask "qlmarkdown"
#brew install --cask "qlstephen"
brew install --cask "qlvideo"
brew install --cask "quicklook-json"
#brew install --cask "quicklook-pat"
#brew install --cask "quicklookapk"
#brew install --cask "quicklookase"
#brew install --cask "suspicious-package"
#brew install --cask "webpquicklook"

#########################
# Cleanup
#########################
brew cleanup

##########################
# Install CLI Tools
##########################
brew install libassuan gnu-pkcs11-scd libgpg-error pkcs11-helper || true
brew install "bash"
brew install "bash-completion"
#brew install "ext4fuse"
brew install "ffmpeg"
#brew install "fuse-ntfs-3g"
brew install "nano"
brew install "python"
brew install "python@3.9"
#brew install "wget"
#brew install "youtube-dl"
#brew install --cask "docker"

##########################
# Rebuild All Packages
##########################
brew list -1 --formulae | xargs -L1 brew reinstall --build-from-source || true
chown -hR ${HOMEBREW_USER}:${HOMEBREW_GROUP} ~/homebrew 2>/dev/null || sudo -E chown -hR ${HOMEBREW_USER}:${HOMEBREW_GROUP} ~/homebrew || true
exit 0