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
if [[ !( -e ~/homebrew ) ]] ; then printf "error\n" ; exit 126 ; fi ;
chflags 'hidden' ~/homebrew 2>/dev/null || true ;
source ~/.bashrc
HOMEBREW_USER=$(stat -f %u ~/homebrew/)
HOMEBREW_GROUP=$(stat -f %g ~/homebrew/)
umask 002
export ENABLE_CLANG_FORMAT=on
export CMAKE_OSX_DEPLOYMENT_TARGET=14.2
export CC=clang
export CXX=clang
export CPP=clang
export CMAKE_PROGRAM_PATH=${PATH}:/Applications/Xcode.app/Contents/Developer/usr/bin
#export SSL_CERT_DIR=??
export CMAKE_APPLE_SILICON_PROCESSOR=x86_64
export CMAKE_BUILD_PARALLEL_LEVEL=8
export CMAKE_OSX_ARCHITECTURES='arm64 x86_64'
export MACOSX_DEPLOYMENT_TARGET=14.2
export CMAKE_XCODE_BUILD_SYSTEM=12 # the new build system
#CMAKE_OSX_SYSROOT
export DT_TOOLCHAIN_DIR=/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain
export HOMEBREW_CASK_OPTS="${HOMEBREW_CASK_OPTS} --appdir=~/homebrew/Applications/ --fontdir=~/homebrew/Library/Fonts"
brew analytics off
caffeinate -dims brew autoremove
caffeinate -dims brew update
caffeinate -dims brew upgrade

##########################
# set aliases
##########################
rm -rf "$(brew --cache)"
caffeinate -dims brew cleanup
caffeinate -dims brew autoremove


##########################
# Rebuild All Packages
##########################

#brew list -1 | xargs -L1 -I{} brew info {} | grep -F "PKG"
for FORMULA_PC_PATH_VAR in $(find ${HOMEBREW_PREFIX:-~/homebrew}/. -iname "pkgconfig" -a -type d 2>/dev/null ; wait ; ) ; do
	pkgpathappend ${FORMULA_PC_PATH_VAR} ; wait ;
done ;
wait ;
echo ""
export PKG_CONFIG_PATH ;
unset FORMULA_PC_PATH_VAR 2>/dev/null || true ;

# hint for better source builds
#for FORMULA_LD_PATH_VAR in $( brew list -1 | xargs -L1 -I{} brew info {} 2>/dev/null | grep -F "FLAGS" | cut -d\= -f 2-2 ; wait ; ) ; do
#for FORMULA_CPP_PATH_VAR in $( brew list -1 | xargs -L1 -I{} brew info {} 2>/dev/null | grep -F "FLAGS" | cut -d\= -f 2-2 ; wait ; ) ; do

#export LDFLAGS="-L${HOMEBREW_PREFIX}/opt/llvm/lib/c++ -Wl,-rpath,${HOMEBREW_PREFIX}/opt/llvm/lib/c++"
#export LDFLAGS="${LDFLAGS} -L${HOMEBREW_PREFIX}/opt/berkeley-db@5/lib"
#export CPPFLAGS="-I${HOMEBREW_PREFIX}/opt/berkeley-db@5/include"


brew list -1 --formulae | xargs -L1 caffeinate -dims brew reinstall --formula --build-from-source || true ;
wait ;
brew outdated -q --casks | xargs -L1 caffeinate -dims brew reinstall --cask --adopt || true ;
wait ;
clear ;
brew list -1 --formulae | xargs -L1 caffeinate -dims brew reinstall --formula --build-from-source || true ;
wait ;
caffeinate -dims brew cleanup
caffeinate -dims brew autoremove
wait ;
chown -hR ${HOMEBREW_USER}:${HOMEBREW_GROUP} ~/homebrew 2>/dev/null || sudo -E chown -hR ${HOMEBREW_USER}:${HOMEBREW_GROUP} ~/homebrew || true
exit 0