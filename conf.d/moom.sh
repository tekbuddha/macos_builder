###############################################################################
# Moom                                                                        #
###############################################################################

# Install the preferences file
cp "${SOURCE}/init/com.manytricks.Moom.plist" ${HOME}/Library/Preferences

killall "Moom" &> /dev/null
