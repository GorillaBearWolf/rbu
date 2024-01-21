#!/usr/bin/env zsh

# Edit rbu.sh and rbu.plist BEFORE executing this script!
# This file needs +x permissions.
# In this terminal directory, run:
# $ chmod +x install.sh
# Then execute this script.

chmod a+x rbu.sh
cp rbu.plist ~/Library/LaunchAgents
launchctl load ~/Library/LaunchAgents/rbu.plist
launchctl start rbu