#! /bin/bash
# Disclaimer of Warranties.
# A. YOU EXPRESSLY ACKNOWLEDGE AND AGREE THAT, TO THE EXTENT PERMITTED BY
#    APPLICABLE LAW, USE OF THIS SHELL SCRIPT AND ANY SERVICES PERFORMED
#    BY OR ACCESSED THROUGH THIS SHELL SCRIPT IS AT YOUR SOLE RISK AND
#    THAT THE ENTIRE RISK AS TO SATISFACTORY QUALITY, PERFORMANCE, ACCURACY AND
#    EFFORT IS WITH YOU.
#
# B. TO THE MAXIMUM EXTENT PERMITTED BY APPLICABLE LAW, THIS SHELL SCRIPT
#    AND SERVICES ARE PROVIDED "AS IS" AND "AS AVAILABLE," WITH ALL FAULTS AND
#    WITHOUT WARRANTY OF ANY KIND, AND THE AUTHOR OF THIS SHELL SCRIPT'S LICENSORS
#    (COLLECTIVELY REFERRED TO AS "THE AUTHOR" FOR THE PURPOSES OF THIS DISCLAIMER)
#    HEREBY DISCLAIM ALL WARRANTIES AND CONDITIONS WITH RESPECT TO THIS SHELL SCRIPT
#    SOFTWARE AND SERVICES, EITHER EXPRESS, IMPLIED OR STATUTORY, INCLUDING, BUT
#    NOT LIMITED TO, THE IMPLIED WARRANTIES AND/OR CONDITIONS OF
#    MERCHANTABILITY, SATISFACTORY QUALITY, FITNESS FOR A PARTICULAR PURPOSE,
#    ACCURACY, QUIET ENJOYMENT, AND NON-INFRINGEMENT OF THIRD PARTY RIGHTS.
#
# C. THE AUTHOR DOES NOT WARRANT AGAINST INTERFERENCE WITH YOUR ENJOYMENT OF THE
#    THE AUTHOR's SOFTWARE AND SERVICES, THAT THE FUNCTIONS CONTAINED IN, OR
#    SERVICES PERFORMED OR PROVIDED BY, THIS SHELL SCRIPT WILL MEET YOUR
#    REQUIREMENTS, THAT THE OPERATION OF THIS SHELL SCRIPT OR SERVICES WILL
#    BE UNINTERRUPTED OR ERROR-FREE, THAT ANY SERVICES WILL CONTINUE TO BE MADE
#    AVAILABLE, THAT THIS SHELL SCRIPT OR SERVICES WILL BE COMPATIBLE OR
#    WORK WITH ANY THIRD PARTY SOFTWARE, APPLICATIONS OR THIRD PARTY SERVICES,
#    OR THAT DEFECTS IN THIS SHELL SCRIPT OR SERVICES WILL BE CORRECTED.
#    INSTALLATION OF THIS THE AUTHOR SOFTWARE MAY AFFECT THE USABILITY OF THIRD
#    PARTY SOFTWARE, APPLICATIONS OR THIRD PARTY SERVICES.
#
# D. YOU FURTHER ACKNOWLEDGE THAT THIS SHELL SCRIPT AND SERVICES ARE NOT
#    INTENDED OR SUITABLE FOR USE IN SITUATIONS OR ENVIRONMENTS WHERE THE FAILURE
#    OR TIME DELAYS OF, OR ERRORS OR INACCURACIES IN, THE CONTENT, DATA OR
#    INFORMATION PROVIDED BY THIS SHELL SCRIPT OR SERVICES COULD LEAD TO
#    DEATH, PERSONAL INJURY, OR SEVERE PHYSICAL OR ENVIRONMENTAL DAMAGE,
#    INCLUDING WITHOUT LIMITATION THE OPERATION OF NUCLEAR FACILITIES, AIRCRAFT
#    NAVIGATION OR COMMUNICATION SYSTEMS, AIR TRAFFIC CONTROL, LIFE SUPPORT OR
#    WEAPONS SYSTEMS.
#
# E. NO ORAL OR WRITTEN INFORMATION OR ADVICE GIVEN BY THE AUTHOR
#    SHALL CREATE A WARRANTY. SHOULD THIS SHELL SCRIPT OR SERVICES PROVE DEFECTIVE,
#    YOU ASSUME THE ENTIRE COST OF ALL NECESSARY SERVICING, REPAIR OR CORRECTION.
#
#    Limitation of Liability.
# F. TO THE EXTENT NOT PROHIBITED BY APPLICABLE LAW, IN NO EVENT SHALL THE AUTHOR
#    BE LIABLE FOR PERSONAL INJURY, OR ANY INCIDENTAL, SPECIAL, INDIRECT OR
#    CONSEQUENTIAL DAMAGES WHATSOEVER, INCLUDING, WITHOUT LIMITATION, DAMAGES
#    FOR LOSS OF PROFITS, CORRUPTION OR LOSS OF DATA, FAILURE TO TRANSMIT OR
#    RECEIVE ANY DATA OR INFORMATION, BUSINESS INTERRUPTION OR ANY OTHER
#    COMMERCIAL DAMAGES OR LOSSES, ARISING OUT OF OR RELATED TO YOUR USE OR
#    INABILITY TO USE THIS SHELL SCRIPT OR SERVICES OR ANY THIRD PARTY
#    SOFTWARE OR APPLICATIONS IN CONJUNCTION WITH THIS SHELL SCRIPT OR
#    SERVICES, HOWEVER CAUSED, REGARDLESS OF THE THEORY OF LIABILITY (CONTRACT,
#    TORT OR OTHERWISE) AND EVEN IF THE AUTHOR HAS BEEN ADVISED OF THE
#    POSSIBILITY OF SUCH DAMAGES. SOME JURISDICTIONS DO NOT ALLOW THE EXCLUSION
#    OR LIMITATION OF LIABILITY FOR PERSONAL INJURY, OR OF INCIDENTAL OR
#    CONSEQUENTIAL DAMAGES, SO THIS LIMITATION MAY NOT APPLY TO YOU. In no event
#    shall THE AUTHOR's total liability to you for all damages (other than as may
#    be required by applicable law in cases involving personal injury) exceed
#    the amount of five dollars ($5.00). The foregoing limitations will apply
#    even if the above stated remedy fails of its essential purpose.
################################################################################
# Homebrew Setup
################################################################################
#PATH="/bin:/sbin:/usr/sbin:/usr/bin"
umask 002

#PKG_CONFIG_PATH=$(echo ""$(find ~/homebrew/lib -iname "pkgconfig" -a -type d 2>/dev/null)":"$(find ~/homebrew/Cellar/python@3.11 -iname "pkgconfig" -a -type d 2>/dev/null | tail -n1 )":"$(find ~/homebrew/Cellar/bash -iname "pkgconfig" -a -type d 2>/dev/null)":"$(find /usr -iname "pkgconfig" -a -type d 2>/dev/null | head -n 1 ; wait ;) ; wait ;) ;

# configure paths
function pkgpathappend() {
	for PKG_CONFIG_PATH_ARG in "$@" ; do
		if [[ -d "$PKG_CONFIG_PATH_ARG" ]] && [[ ":$PKG_CONFIG_PATH:" != *":$PKG_CONFIG_PATH_ARG:"* ]] ; then
			PKG_CONFIG_PATH="${PKG_CONFIG_PATH:+"$PKG_CONFIG_PATH:"}$PKG_CONFIG_PATH_ARG" ;
			export PKG_CONFIG_PATH ;
		fi ;
	done ;
	wait ;
	unset PKG_CONFIG_PATH_ARG 2>/dev/null || true ;
}

#for FORMULA_PC_PATH_VAR in $( brew list -1 | xargs -L1 -I{} brew info {} 2>/dev/null | grep -F "PKG" | cut -d\= -f 2-2 ; wait ; ) ; do

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
export HOMEBREW_CASK_OPTS="${HOMEBREW_CASK_OPTS} --appdir=~/homebrew/Applications/ --fontdir=~/homebrew/Library/Fonts"
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
brew install "openssl@3"
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
#brew install --cask "twitch"

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
brew install "gnupg-pkcs11-scd" || true
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
brew install --cask "virtualbox"
brew install --cask "virtualbox-extension-pack"

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
#brew install --cask "qlimagesize"
brew install --cask "qlmarkdown"
#brew install --cask "qlstephen"
#brew install --cask "qlvideo"
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
brew install "python@3.10"
brew install "python@3.11"
#brew install "wget"
brew install "curl"
#brew install "youtube-dl"
brew install --cask "docker"

##########################
# Rebuild All Packages
##########################

#brew list -1 | xargs -L1 -I{} brew info {} | grep -F "PKG"
for FORMULA_PC_PATH_VAR in $(find ~/homebrew/. -iname "pkgconfig" -a -type d 2>/dev/null ; wait ; ) ; do
	pkgpathappend ${FORMULA_PC_PATH_VAR} ; wait ;
done ;
wait ;
echo ""
export PKG_CONFIG_PATH ;
unset FORMULA_PC_PATH_VAR 2>/dev/null || true ;

brew list -1 --formulae | xargs -L1 caffeinate -dims brew reinstall --build-from-source || true ;
wait ;
chown -hR ${HOMEBREW_USER}:${HOMEBREW_GROUP} ~/homebrew 2>/dev/null || sudo -E chown -hR ${HOMEBREW_USER}:${HOMEBREW_GROUP} ~/homebrew || true
exit 0