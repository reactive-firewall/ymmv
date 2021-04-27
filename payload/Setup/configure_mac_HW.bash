#! /bin/bash
# mac OS provisioning sample
HOSTNAME="${HOSTNAME:-Computer}"
sudo scutil --set ComputerName "${HOSTNAME}"
sudo scutil --set LocalHostName "${HOSTNAME}"
sudo pmset -a destroyfvkeyonstandby 1
sudo pmset -a hibernatemode 25
sudo pmset -a powernap 0
sudo pmset -a standby 0
sudo pmset -a standbydelay 0
sudo pmset -a autopoweroff 0
echo "now set firmware password" ;
exit 0
