#!/bin/bash
###############################################################################
# Vagrant                                                                     #
###############################################################################

# This script prefers bento boxes (https://github.com/chef/bento) and the
# virtualbox provider.
boxes="centos-6.6 centos-6.7 centos-7.1 centos-7.2 centos-7.3 ubuntu-12.04 ubuntu-14.04 ubuntu-14.10 ubuntu-15.04 ubuntu-15.10 ubuntu-16.04 ubuntu-16.10 ubuntu-17.04"

for currentBox in $boxes
 do
  if [ `ls ~/.vagrant.d/boxes/ | grep ${currentBox}` ]
   then
    echo " ${currentBox} already exists. Skipping..."
  else
    vagrant box add bento/${currentBox} --provider virtualbox
  fi
 done
