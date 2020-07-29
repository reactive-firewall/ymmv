#!/usr/bin/env bash

###############################################################################
# Preliminary Setup                                                           #
###############################################################################

if [ -t 1 ] ; then echo "Configuring Shell" ; fi

# Add bash shells
sudo bash -c 'echo $(command -v bash) | tee /etc/shells'
sudo bash -c 'echo $(command -v sh) | tee -a /etc/shells'

# Set default shell for the current user
chsh -s $(command -v bash)
