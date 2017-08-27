#!/bin/bash

# This will set your default shell to a brew installed bash4 shell if it is found.

if [ -e /usr/local/bin/bash ]
then
 echo "Found bash4 brew binary. Adding to /etc/shells and changing..."
 sudo sh -c "echo '/usr/local/bin/bash' >> /etc/shells"
 chsh -s /usr/local/bin/bash `whoami`
else
 echo "No bash4 brew binary found."
fi