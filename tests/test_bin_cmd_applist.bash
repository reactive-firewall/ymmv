#! /bin/bash
# Disclaimer of Warranties.
# A. YOU EXPRESSLY ACKNOWLEDGE AND AGREE THAT, TO THE EXTENT PERMITTED BY
#    APPLICABLE LAW, USE OF THIS SHELL SCRIPT AND ANY SERVICES PERFORMED
#    BY OR ACCESSED THROUGH THIS SHELL SCRIPT IS AT YOUR SOLE RISK AND
#    THAT THE ENTIRE RISK AS TO SATISFACTORY QUALITY, PERFORMANCE, ACCURACY AND
#    EFFORT IS WITH YOU.
#
# B. TO THE MAXIMUM EXTENT PERMITTED BY APPLICABLE LAW, THIS SHELL SCRIPT
#    AND SERVICES ARE PROVIDED "AS IS" AND "AS AVAILABLE", WITH ALL FAULTS AND
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

# test must run within 15 seconds or fails by timeout
ulimit -t 15
PATH="/bin:/sbin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin:./payload/bin:${PATH}"
umask 027

LOCK_FILE="/tmp/org.pak.ymmv.test_bin_cmd_applist.lock" ;
EXIT_CODE=1

test -x $(command -v grep) || exit 126 ;
test -x $(command -v curl) || exit 126 ;
test -x $(command -v find) || exit 126 ;
test -x $(command -v git) || exit 126 ;
hash -p ./.github/tool_shlock_helper.sh shlock || exit 255 ;
test -x $(command -v shlock) || exit 126 ;

function cleanup() {
	rm -f "${LOCK_FILE}" 2>/dev/null || true ; wait ;
	hash -d shlock 2>/dev/null > /dev/null || true ;
}

if [[ $(uname -s) == Darwin* ]] ; then

if [[ ( $(shlock -f ${LOCK_FILE} -p $$ ) -eq 0 ) ]] ; then
		EXIT_CODE=0
		trap 'cleanup ; wait ; exit 3 ;' SIGHUP || EXIT_CODE=3
		trap 'cleanup ; wait ; exit 4 ;' SIGTERM || EXIT_CODE=4
		trap 'cleanup ; wait ; exit 5 ;' SIGQUIT || EXIT_CODE=5
		# SC2173 - https://github.com/koalaman/shellcheck/wiki/SC2173
		# trap 'rm -f ${LOCK_FILE} 2>/dev/null || true ; wait ; exit 1 ;' SIGSTOP || EXIT_CODE=7
		trap 'cleanup ; wait ; exit 8 ;' SIGINT || EXIT_CODE=8
		trap 'cleanup ; wait ; exit 9 ;' SIGABRT || EXIT_CODE=9
		trap 'cleanup ; wait ; exit ${EXIT_CODE} ;' EXIT || EXIT_CODE=1
else
		echo "FAIL" >&2 ;
		false ;
		EXIT_CODE=127 ;
fi ;


# THIS IS THE ACTUAL TEST
if [[ -d ../payload ]] ; then
	test -x $(../payload/bin/applist.bash "/bin/bash") || EXIT_CODE=2
elif [[ -d ./payload/bin ]] ; then
	test -x $(./payload/bin/applist.bash "/bin/bash") || EXIT_CODE=2
elif [[ -f ./bin/applist.bash ]] ; then
	test -x $(./bin/applist.bash "/bin/bash") || EXIT_CODE=2
else
	echo "FAIL: missing 'applist.bash' source file"
	EXIT_CODE=1
fi

fi ;

if [[ ( ${EXIT_CODE} -ne 0 ) ]] ; then
	case "$EXIT_CODE" in
		0) true ;; #  dead-code
		127) false ;;
		*) echo "SKIP: Unclassified issue with 'applist.bash'" ;;
	esac
fi

cleanup || rm -f ${LOCK_FILE} 2>/dev/null > /dev/null || true ; wait ;

# goodbye
exit ${EXIT_CODE:-255} ;
