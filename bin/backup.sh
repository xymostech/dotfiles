#!/usr/bin/env bash

OUTPUT=$(date "+%d-%m-%Y-backup.log")
echo "Writing to $OUTPUT"

if mount | grep -q "/media/Backup"
then
    sudo rsync \
         --partial \
         --progress \
         --archive \
         --verbose \
         --delete \
        --exclude="/tmp/*" \
        --exclude="/sys/*" \
        --exclude="/proc/*" \
        --exclude="/dev/*" \
        --exclude="/run/*" \
        --exclude="/boot/*" \
        --exclude="/media/*" \
        --exclude="/mnt/*" \
        --exclude="/swapfile*" \
        --exclude="/home/xymostech/Downloads/*" \
        --exclude="/home/xymostech/Dropbox/*" \
        --exclude="/home/xymostech/.steam/*" \
        --exclude="/home/xymostech/.local/share/Steam/*" \
        --exclude="/home/xymostech/khan/webapp/.git/modules/*" \
        / \
        /media/Backup > "$OUTPUT"
else
    echo "Backup drive isn't mounted"
    exit 1
fi
