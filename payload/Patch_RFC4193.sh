#!/bin/bash
#############################################
# AUTHOR: REACTIVE-FIREWALL                 #
# VERSION 1.00 RELEASE DATE OCT 15 2020     #
# DESC:  FORCE rfc4193 PREFIX ONLY          #
#############################################
#REQUIREMENTS:
#  OS X 10.15 or newer
#############################################
#CHECK FOR OS X 10.15
if [[  $(sw_vers -productVersion | grep '10.15')  ]] || [[  $(sw_vers -productVersion | grep '11.1')  ]]
then
   if [[ -f /etc/sysctl.conf ]]
   then
      if grep 'rfc4193' /etc/sysctl.conf > /dev/null 2>&1
      then
         echo "PATCH WAS PREVIOUSLY ENABLED"
         exit
      fi
    fi
         sudo sysctl -w net.inet6.ip6.only_allow_rfc4193_prefixes=1  > /dev/null 2>&1
         echo "net.inet6.ip6.only_allow_rfc4193_prefixes=1" | sudo tee -a /etc/sysctl.conf  > /dev/null 2>&1
         sudo chown root:wheel /etc/sysctl.conf
         sudo chmod 644 /etc/sysctl.conf
         echo "PATCH ENABLED"
fi