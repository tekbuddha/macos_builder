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


# Sync .dotfiles from Github
echo
msginfo "Cloning .dotfiles from Github"
git clone https://github.com/tekbuddha/dotfiles.git .dotfiles
cd .dotfiles
./create_symlinks.sh
cd

# Install Homebrew
echo
msginfo "Installing homebrew..."
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew doctor

# Install Homebrew taps
brew tap homebrew/binary
brew tap phinze/homebrew-cask
brew tap caskroom/versions
brew tap caskroom/fonts

# Brew Utilities
brew install brew-cask
brew install coreutils
brew install grc
brew install httpie
brew install nmap
brew install packer
brew install p7zip
brew install tmux
brew install unrar
brew install wget

# Cask Web Browsers
#brew cask install google-chrome-canary
#brew cask install firefox
 
# Cask Development Tools
brew cask install sublime-text3
brew cask install sourcetree
brew cask install vagrant
brew cask install virtualbox
# brew cask install vmware-fusion
brew cask install xquartz

# Cask Utilities
# brew cask install automatic
brew cask install bartender
brew cask install dropbox
brew cask install electric-sheep
#brew cask install fitbit-connect
brew cask install flux
brew cask install istat-menus
#brew cask install onepassword
brew cask install quicksilver
brew cask install skype
brew cask install synergy
brew cask install transmission

# Cask OmniSuite
brew cask install omnigraffle

# Cask Entertainment Software
brew cask install flash-player
brew cask install linein
brew cask install plex-home-theater
brew cask install silverlight
brew cask install spotify
brew cask install steam
brew cask install vlc
brew cask install xld

# Cask Fonts
brew cask install caskroom/fonts/font-source-code-pro

# Presumptious configuration ahead!

# Clean up Dock & Downloads
msginfo "Emptying your Dock and the Downloads folder."

defaults write com.apple.dock persistent-apps -array ""
killall Dock

if [ -e ~/Downloads/About\ Downloads.lpdf ]
    then
    	rm -Rf ~/Downloads/About\ Downloads.lpdf
fi

# Make ~/Library visibile"
msginfo "Making Library visible."
chflags nohidden ~/Library

msginfo "Setting some system-wide preferences."

# Menu bar: disable transparency
defaults write NSGlobalDomain AppleEnableMenuBarTransparency -bool false

# Set sidebar icon size to medium
defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 2

# Disable opening and closing window animations
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false

# Increase window resize speed for Cocoa applications
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true

# Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true

# Save to disk (not to iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Automatically quit printer app once the print jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Disable the crash reporter
defaults write com.apple.CrashReporter DialogType -string "none"

# Set Help Viewer windows to non-floating mode
defaults write com.apple.helpviewer DevMode -bool true

# Reveal IP address, hostname, OS version, etc. when clicking the clock in the
# login window
sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName

# Restart automatically if the computer freezes
systemsetup -setrestartfreeze on

# Never go into computer sleep mode
systemsetup -setcomputersleep Off > /dev/null

# Check for software updates daily, not just once per week
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1


## Trackpad, mouse, keyboard, Bluetooth accessories, and input

# Increase sound quality for Bluetooth headphones/headsets
defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40

# Enable full keyboard access for all controls
# (e.g. enable Tab in modal dialogs)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Automatically illuminate built-in MacBook keyboard in low light
defaults write com.apple.BezelServices kDim -bool true

# Turn off keyboard illumination when computer is not used for 5 minutes
defaults write com.apple.BezelServices kDimTime -int 300

# Set language and text formats
defaults write NSGlobalDomain AppleLanguages -array "en" "nl"
defaults write NSGlobalDomain AppleLocale -string "en_US@currency=USD"
defaults write NSGlobalDomain AppleMeasurementUnits -string "Inches"
defaults write NSGlobalDomain AppleMetricUnits -bool false

# Set the timezone; see `systemsetup -listtimezones` for other values
systemsetup -settimezone "America/Los_Angeles" > /dev/null


## Screen

# Require password immediately after sleep or screen saver begins
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 5

# Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
defaults write com.apple.screencapture type -string "png"

# Disable shadow in screenshots
defaults write com.apple.screencapture disable-shadow -bool true


## Finder

# Finder: disable window animations and Get Info animations
defaults write com.apple.finder DisableAllAnimations -bool true

# Show icons for hard drives, servers, and removable media on the desktop
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true
# defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true

# Finder: don't show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool false

# Finder: show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Finder: show path bar
defaults write com.apple.finder ShowPathBar -bool true

# Finder: allow text selection in Quick Look
defaults write com.apple.finder QLEnableTextSelection -bool true

# Don't display full POSIX path as Finder window title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool false

# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Enable spring loading for directories
defaults write NSGlobalDomain com.apple.springing.enabled -bool true

# Remove the spring loading delay for directories
defaults write NSGlobalDomain com.apple.springing.delay -float 0

# Avoid creating .DS_Store files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Disable disk image verification
defaults write com.apple.frameworks.diskimages skip-verify -bool true
defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true

# Automatically open a new Finder window when a volume is mounted
defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true

# Show item info to the right of the icons on the desktop
/usr/libexec/PlistBuddy -c "Set DesktopViewSettings:IconViewSettings:labelOnBottom false" ~/Library/Preferences/com.apple.finder.plist

# Increase grid spacing for icons on the desktop and in other icon views
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:gridSpacing 50" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:gridSpacing 50" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:gridSpacing 50" ~/Library/Preferences/com.apple.finder.plist

# Increase the size of icons on the desktop and in other icon views
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:iconSize 44" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:iconSize 44" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:iconSize 44" ~/Library/Preferences/com.apple.finder.plist

# Use column view in all Finder windows by default
defaults write com.apple.finder FXPreferredViewStyle -string "clmv"

# Enable AirDrop over Ethernet and on unsupported Macs running Lion
defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true

# Expand the following File Info panes:
# 'General', 'Open With', and 'Sharing & Permissions'
defaults write com.apple.finder FXInfoPanesExpanded -dict \
  General -bool true \
  OpenWith -bool true \
  Privileges -bool true


## Dock, Dashboard, and hot corners

# Disable spring loading for all Dock items
defaults write com.apple.dock enable-spring-load-actions-on-all-items -bool false

# Hide indicator lights for open applications in the Dock
defaults write com.apple.dock show-process-indicators -bool false

# Don't animate opening applications from the Dock
defaults write com.apple.dock launchanim -bool false

# Speed up Mission Control animations
defaults write com.apple.dock expose-animation-duration -float 0.1

# Remove the auto-hiding Dock delay
defaults write com.apple.dock autohide-delay -float 0

# Remove the animation when hiding/showing the Dock
defaults write com.apple.dock autohide-time-modifier -float 0.4

# Disable automatically hide and show the Dock
defaults write com.apple.dock autohide -bool false

# Make Dock more transparent
defaults write com.apple.dock hide-mirror -bool true


## iTunes

# Disable the iTunes store link arrows
defaults write com.apple.iTunes show-store-arrow-links -bool NO

# Disable the Genius sidebar in iTunes
defaults write com.apple.iTunes disableGeniusSidebar -bool true

# Disable radio stations in iTunes
defaults write com.apple.iTunes disableRadio -bool true


## Activity Monitor

# Show the main window when launching Activity Monitor
defaults write com.apple.ActivityMonitor OpenMainWindow -bool true

# Visualize CPU usage in the Activity Monitor Dock icon
defaults write com.apple.ActivityMonitor IconType -int 5

# Show all processes in Activity Monitor
defaults write com.apple.ActivityMonitor ShowCategory -int 0

# Sort Activity Monitor results by CPU usage
defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
defaults write com.apple.ActivityMonitor SortDirection -int 0


## Miscellaneous

# TextEdit: Use plain text mode for new documents.
defaults write com.apple.TextEdit RichText -int 0

# TextEdit: Open and save files as UTF-8.
defaults write com.apple.TextEdit PlainTextEncoding -int 4
defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4

# Disk Utility: Enable the debug menu.
defaults write com.apple.DiskUtility DUDebugMenuEnabled -bool true
defaults write com.apple.DiskUtility advanced-image-options -bool true

# Messages: Disable automatic emoji substitution (i.e. use plain text smileys).
defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticEmojiSubstitutionEnablediMessage" -bool false


## Kill affected applications.

for app in "Activity Monitor" "Contacts" "cfprefsd" "Dock" "Finder" "iTunes" "Mail" "Messages" "SystemUIServer"; do
	killall "$app" > /dev/null 2>&1
done


## Vagrant Boxes (Optional)
# vagrant box add opscode-ubuntu-12.04 http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_ubuntu-12.04_chef-provisionerless.box
# vagrant box add opscode-ubuntu-12.10 http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_ubuntu-12.10_chef-provisionerless.box
# vagrant box add opscode-ubuntu-14.04 http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_ubuntu-14.04_chef-provisionerless.box
# vagrant box add opscode-ubuntu-14.10 http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_ubuntu-14.10_chef-provisionerless.box
# vagrant box add opscode-centos-6.4 http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_centos-6.4_chef-provisionerless.box
# vagrant box add opscode-centos-6.5 http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_centos-6.5_chef-provisionerless.box
# vagrant box add opscode-centos-6.6 http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_centos-6.6_chef-provisionerless.box
# vagrant box add opscode-centos-7.0 http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_centos-7.0_chef-provisionerless.box
