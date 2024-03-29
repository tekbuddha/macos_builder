#!/bin/bash
###############################################################################
# Vagrant                                                                     #
###############################################################################

# This script prefers bento boxes (https://github.com/chef/bento) and the
# virtualbox provider.
boxes="bento/ubuntu-18.04 bento/ubuntu-20.04"

for currentBox in $boxes
 do
  if [ `ls ~/.vagrant.d/boxes/ | grep ${currentBox}` ]
   then
    echo " ${currentBox} already exists. Skipping..."
  else
    vagrant box add ${currentBox} --provider virtualbox
  fi
 done
