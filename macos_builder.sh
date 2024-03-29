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

# Useful variable for being able to copy files from ./init
SOURCE=`pwd`

# Acquire some knowledge about user...
username=`whoami`
realname=`id -F`
firstname=`echo $realname | awk '{print $1}'`
lastname=`echo $realname | awk '{print $2}'`

# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

# Getting started...
msginfo "Hello, ${firstname}. We're going to get this Mac into shape."
msgalert "First, I need sudo privileges! I may ask a few more times during this process."

sudo -v

# Keep-alive: update existing `sudo` time stamp until `.macos` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &


# Configure workstation's name
msgalert "What do you want to name this Mac? (Recommended all lowercase, no spaces.)"
msginput 
read macname

msginfo "Okay, setting this box up as $macname"

sudo scutil --set ComputerName $macname
sudo scutil --set HostName "${macname}.local"

# Install Homebrew
echo
if [ `which brew` ]
then
	echo "brew already installed. Skipping..."
else
	msginfo "Installing homebrew..."
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
	brew doctor
fi

# Install brew packages (including Mac AppStore packages) via Brewfile
msginfo "Installing packages from brew bundle..."
brew bundle


# Begin applying system and application defaults
msginfo "Inspecting conf.d for setting MacOS and application defaults..."

for appConf in `ls conf.d`
 do
  msginfo "Executing ${appConf}..."

  source conf.d/${appConf}
 done

msgalert "Done. Note that some of these changes require a logout/restart to take effect."
