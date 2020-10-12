#! /bin/bash
#########################
# Homebrew Setup
#########################
umask 002
#ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
if [[ !( -e ~/homebrew ) ]] ; then
mkdir homebrew && curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C homebrew
chflags 'hidden' homebrew || true ;
source ~/.bashrc
fi
HOMEBREW_USER=$(stat -f %u ~/homebrew/)
HOMEBREW_GROUP=$(stat -f %g ~/homebrew/)
umask 002
brew analytics off
brew update
brew upgrade

##########################
# Tap Homebrew Repos
##########################
brew tap "homebrew/core"
brew tap "homebrew/cask"

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
#brew cask install "google-drive-file-stream"

#########################
# Email / Messaging Apps
#########################
#brew cask install "slack"
#brew cask install "twitch"

#########################
# Files Apps
#########################
#brew cask install "send-to-kindle"
#brew cask install "timemachineeditor"

#########################
# Media Apps
#########################
#brew cask install "max"
#brew cask install "musicbrainz-picard"
#brew cask install "vlc"
brew cask install "gimp"

#########################
# Security Apps
#########################
brew install "libassuan"
brew install "gnu-pkcs11-scd" || true
brew install "libgpg-error"
brew install "pkcs11-helper"
brew install "gpg-suite-pinentry" || true
brew cask install openSC || true

#########################
# Programming Apps
#########################
# brew cask install "android-file-transfer"
# brew cask install "bbedit"
# brew cask install "github"
# brew cask install "osxfuse"
# brew cask install "sublime-text"
# brew cask install "virtualbox"
# brew cask install "virtualbox-extension-pack"

#########################
# Gaming Apps
#########################
#brew cask install "battle-net"
#brew cask install "starcraft"
#brew cask install "steam"
#brew cask install "steamcmd"

#########################
# Quick Look Apps
#########################
#brew cask install "provisionql"
#brew cask install "qlcolorcode"
#brew cask install "qlimagesize"
brew cask install "qlmarkdown"
#brew cask install "qlstephen"
#brew cask install "qlvideo"
brew cask install "quicklook-json"
#brew cask install "quicklook-pat"
#brew cask install "quicklookapk"
#brew cask install "quicklookase"
#brew cask install "suspicious-package"
#brew cask install "webpquicklook"

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
#brew install "ffmpeg"
#brew install "fuse-ntfs-3g"
brew install "nano"
brew install "python"
brew install "python3"
#brew install "wget"
#brew install "youtube-dl"
brew cask install docker

##########################
# Rebuild All Packages
##########################
brew list | xargs brew reinstall --build-from-source
sudo -E chown -hR ${HOMEBREW_USER}:${HOMEBREW_GROUP} ~/homebrew || true