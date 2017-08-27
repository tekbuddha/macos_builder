#!/bin/bash

# This script is used to get a new OS X workstation as-close-to-useable
# as possible in a single shot. It is presumptiuous in many ways, but
# does take some feedback with regards to "optional" components.
#
# Prior to installation, please ensure XCode has been started once and
# the EULA has been accepted. Failure to do so will prevent portions of
# this script from executing properly.

# Some setup...
function msginfo {
	echo "💬  $1"
}

function msginput {
	echo -n "👉  "
}

function msgalert {
	echo "📣  $1"
}


# Acquire some knowledge about user...
username=`whoami`
realname=`id -F`
firstname=`echo $realname | awk '{print $1}'`
lastname=`echo $realname | awk '{print $2}'`

# Getting started...
msginfo "Hello, ${firstname}. We're going to get this Mac into shape."
msgalert "First, I need sudo privileges!"

sudo -v

# Keep-alive: update existing `sudo` time stamp until we've finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &


# Configure workstation's name
msgalert "What do you want to name this Mac? (Recommended all lowercase, no spaces.)"
msginput 
read macname

msginfo "Okay, setting this box up as $macname"

sudo scutil --set ComputerName $macname
sudo scutil --set HostName "${macname}.home"

# Install Homebrew
echo
if [ `which brew` ]
then
	echo "brew already installed. Skipping..."
else
	msginfo "Installing homebrew..."
	ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	brew doctor
fi

# Install brew packages (including Mac AppStore packages) via Brewfile
brew bundle


# Presumptious configuration ahead!

# Clean up Dock & Downloads
msginfo "Emptying your Dock and the Downloads folder."

defaults write com.apple.dock persistent-apps -array ""
killall Dock

if [ -e ~/Downloads/About\ Downloads.lpdf ]
    then
    	rm -Rf ~/Downloads/About\ Downloads.lpdf
fi

msginfo "Setting MacOS (and application) defaults."
source macos-defaults.sh


## Vagrant Boxes (Optional)
# vagrant box add opscode-ubuntu-12.04 http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_ubuntu-12.04_chef-provisionerless.box
# vagrant box add opscode-ubuntu-12.10 http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_ubuntu-12.10_chef-provisionerless.box
# vagrant box add opscode-ubuntu-14.04 http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_ubuntu-14.04_chef-provisionerless.box
# vagrant box add opscode-ubuntu-14.10 http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_ubuntu-14.10_chef-provisionerless.box
# vagrant box add opscode-centos-6.4 http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_centos-6.4_chef-provisionerless.box
# vagrant box add opscode-centos-6.5 http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_centos-6.5_chef-provisionerless.box
# vagrant box add opscode-centos-6.6 http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_centos-6.6_chef-provisionerless.box
# vagrant box add opscode-centos-7.0 http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_centos-7.0_chef-provisionerless.box
