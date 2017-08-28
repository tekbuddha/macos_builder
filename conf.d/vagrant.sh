#!/bin/bash
###############################################################################
# Vagrant                                                                     #
###############################################################################

# Add vagrant boxes
vagrant box add bento/centos-6.4 --provider virtualbox
vagrant box add bento/centos-6.5 --provider virtualbox
vagrant box add bento/centos-6.6 --provider virtualbox
vagrant box add bento/centos-6.7 --provider virtualbox
vagrant box add bento/centos-7.0 --provider virtualbox
vagrant box add bento/centos-7.1 --provider virtualbox
vagrant box add bento/centos-7.2 --provider virtualbox
vagrant box add bento/centos-7.3 --provider virtualbox
vagrant box add bento/centos-7.4 --provider virtualbox

vagrant box add bento/ubuntu-12.04 --provider virtualbox
vagrant box add bento/ubuntu-12.10 --provider virtualbox
vagrant box add bento/ubuntu-14.04 --provider virtualbox
vagrant box add bento/ubuntu-14.10 --provider virtualbox
vagrant box add bento/ubuntu-15.04 --provider virtualbox
vagrant box add bento/ubuntu-15.10 --provider virtualbox
vagrant box add bento/ubuntu-16.04 --provider virtualbox
vagrant box add bento/ubuntu-16.10 --provider virtualbox
vagrant box add bento/ubuntu-17.04 --provider virtualbox