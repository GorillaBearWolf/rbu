#!/bin/bash

# RBU, RemoteBorgUp, a backup script using BorgBackup on MacOS.
# Update $BORG_REPO, $BORG_REMOTE_PATH, and $SSH for authentication.
# Visit BorgBackup docs [https://borgbackup.readthedocs.io/] for help.
# Add paths to $FOLDERS separated by spaces to include them in the backup.
# $ANCHOR is an anchor file to log the last backup datetime.
# The --dry-run flag is set by default to prevent accidental data egress.

BORG_REPO="repoName"
BORG_REMOTE_PATH="repoPath"
SSH="$HOME/.ssh/identityFile"
FOLDERS=("/path/to/folder" "/path/to/folder")
ANCHOR="$HOME/.rbu"
DATE="$(date +%F_%H:%M:%S)"

if [ -e "$SSH" ]; then
    touch "$ANCHOR"
    echo "$DATE" > "$ANCHOR"
    ssh-add "$SSH"
    borg create --dry-run --progress --stats ::$(hostname)-$(date -Iminutes) "${FOLDERS[@]}"
    ssh-add -d "$SSH"
else
    echo "Identity file not found, update \$SSH with an active key."
fi