#!/bin/bash
###############################################################################
# Shush                                                                       #
###############################################################################

# Set hotkey behavior
# 0 - Hold to unmute - "Push-to-talk"
# 1 - Hold to mute - "Push-to-silence"
defaults write com.mizage.shush hotkeyBehavior -int 0

# Change menu bar icon when (un)muted
defaults write com.mizage.shush animateMenuBarIcon -bool true

# Double-tap hotkey (default is Fn) to (un)mute
# If true, don't forget to disable existing hotkey in System Preferences
defaults write com.mizage.shush doubleTapLock -bool true

# Play audio cues when (un)muting
defaults write com.mizage.shush playAudioCues -bool false

killall "Shush" &> /dev/null