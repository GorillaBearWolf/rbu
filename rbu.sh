#!/usr/bin/env zsh

# RBU, RemoteBorgUp, a backup script using BorgBackup on MacOS.
# Update $BORG_REPO, $BORG_REMOTE_PATH, and $SSH for authentication.
# Visit BorgBackup [https://borgbackup.readthedocs.io/] for help.
# These can be removed if set as environment variables.
# Add local paths to $FOLDERS separated by spaces to archive them.
# $ANCHOR is an anchor file to log the last backup datetime.
# The --dry-run flag is set by default to prevent accidental data egress.

BORG_REPO="repoName"
BORG_REMOTE_PATH="repoPath"
SSH="$HOME/.ssh/identityFile"
FOLDERS=("/path/to/folder" "/path/to/folder")
ANCHOR="$HOME/.rbu"
DATE="$(date +%F_%H:%M:%S)"

if [ -e "$SSH" ]; then
    echo "Updating anchor file..."
    touch "$ANCHOR"
    echo "$DATE" > "$ANCHOR"
    echo "File updated: "$ANCHOR""
    echo "Adding identity file..."
    ssh-add "$SSH"
    echo "Creating archive..."
    borg create --dry-run --progress --stats ::$(hostname)-$(date -Iminutes) "${FOLDERS[@]}"
    echo "Archive created."
    echo "Removing identity file..."
    ssh-add -d "$SSH"
    echo "Backup successful."
else
    echo "Identity file not found, update \$SSH with an active key."
fi