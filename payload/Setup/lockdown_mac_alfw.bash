#! /bin/bash
# uncomment to use for provision
# TOOLS_DIR=$(dirname $0)
# "${TOOLS_DIR}/lockdown_filevault_sleep.bash" || true
# sudo firmwarepasswd -verify
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setloggingmode on
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setstealthmode on
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setallowsigned on
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setallowsignedapp off
#requires Mac tools installed
# find /Applications -iname "*.app" -print0 2>/dev/null | xargs -0 -L1 -I{} auditALFW {}
# find /Applications -iname "*.dylib" -print0 2>/dev/null | xargs -0 -L1 -I{} auditALFW {}
sudo pkill -HUP socketfilterfw
exit 0 ;
