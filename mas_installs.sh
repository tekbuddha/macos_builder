# This script relies upon the tool mas (https://github.com/mas-cli/mas) to
# install applications from the Mac App Store. It's very simple, iterating
# through a list of packages

# 443987910 1Password
# 1019272813 Acorn
# 918858936 Airmail 3
# 438292371 Amadeus Pro
# 1091189122 Bear
# 1081203896 BrowserFreedom
# 696977615 Capo
# 411643860 DaisyDisk
# 847496013 Deckset
# 406056744 Evernote
# 682658836 GarageBand
# 418138339 HTTP Client
# 450442327 Kaspersky Virus Scanner
# 409183694 Keynote
# 405399194 Kindle
# 986304488 Kiwi for Gmail
# 634148309 Logic Pro X
# 634159523 MainStage 3
# 890031187 Marked 2
# 715768417 Microsoft Remote Desktop
# 992076693 MindNode
# 419330170 Moom
# 409203825 Numbers
# 867299399 OmniFocus
# 404651688 OmniGraphSketcher
# 409201541 Pages
# 451907568 Paprika Recipe Manager
# 429449079 Patterns
# 407963104 Pixelmator
# 499768540 Power JSON Editor
# 446107677 Screens
# 496437906 Shush
# 803453959 Slack
# 413965349 Soulver
# 886882234 Tag Editor
# 403012667 Textual
# 403388562 Transmit
# 557168941 Tweetbot
# 1147396723 WhatsApp
# 411680127 WiFi Scanner

mas_packages="443987910 1019272813 918858936 438292371 1091189122 1081203896 696977615 411643860 847496013 406056744 682658836 418138339 450442327 409183694 405399194 986304488 634148309 634159523 890031187 715768417 992076693 419330170 409203825 867299399 404651688 409201541 451907568 429449079 407963104 499768540 446107677 496437906 803453959 413965349 886882234 403012667 403388562 557168941 1147396723 411680127"



for pkg in ${mas_packages}; do
    if mas list | grep -q "^${pkg}"; then
        echo "Package '$pkg' is installed, skipping!"
    else
        echo "Package '$pkg' is not installed, installing!"
        mas install $pkg
    fi
done