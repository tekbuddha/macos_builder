#!/bin/bash

# This will set your default shell to a brew installed bash4 shell if it is found.

if [ -e /usr/local/bin/bash ]
then
 echo " Found bash4 brew binary."
 
 if [ `grep /usr/local/bin/bash /etc/shells` ]
  then
   echo " Found bash4 brew binary entry in /etc/shells."
  else
   echo " Adding to /etc/shells..."
   sudo sh -c "echo '/usr/local/bin/bash' >> /etc/shells"
 fi

 if [ $SHELL="/usr/local/bin/bash" ]
  then
   echo " Shell is set to bash4 brew binary."
  else
   chsh -s /usr/local/bin/bash ${username}
fi

else
 echo "No bash4 brew binary found. Skipping changes to shell..."
fi