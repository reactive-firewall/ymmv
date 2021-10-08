#!/bin/bash
#############################################
# AUTHOR: REACTIVE-FIREWALL                 #
# VERSION 1.00 RELEASE DATE OCT 15 2020     #
# DESC:  Disable BRAIN-DEAD MacOS ARP Cache #
#############################################
#REQUIREMENTS:
#  OS X 10.15 or newer
#############################################
#CHECK FOR OS X 10.15
if [[  $(sw_vers -productVersion | grep '10.15')  ]] || [[  $(sw_vers -productVersion | grep '11.')  ]]
then
	if [[ -f /etc/sysctl.conf ]]
	then
		if grep 'unicast' /etc/sysctl.conf > /dev/null 2>&1
		then
			echo "PATCH WAS PREVIOUSLY ENABLED"
			exit 0;
		fi
	fi
	sudo sysctl -w net.link.ether.inet.arp_unicast_lim=0  > /dev/null 2>&1
	echo "net.link.ether.inet.arp_unicast_lim=0" | sudo tee -a /etc/sysctl.conf  > /dev/null 2>&1
	sudo chown root:wheel /etc/sysctl.conf
	sudo chmod 644 /etc/sysctl.conf
	echo "PATCH ENABLED"
fi