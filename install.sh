chmod a+x rbu.sh
cp rbu.plist ~/Library/LaunchAgents
launchctl load ~/Library/LaunchAgents/rbu.plist
launchctl start rbu