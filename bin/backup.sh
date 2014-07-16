#!/usr/bin/env bash

mount | grep -q "/media/Backup"
if test $?
then
    echo "Backup drive isn't mounted"
    exit 1
fi

sudo rsync --partial --progress --archive --verbose --delete \
    --exclude="/tmp/*" \
    --exclude="/sys/*" \
    --exclude="/proc/*" \
    --exclude="/dev/*" \
    --exclude="/run/*" \
    --exclude="/boot/*" \
    --exclude="/media/*" \
    --exclude="/mnt/*" \
    --exclude="/swapfile" \
    --exclude="/home/xymostech/Downloads/*" \
    --exclude="/home/xymostech/Dropbox/*" \
    --exclude="/home/xymostech/.steam/*" \
    --exclude="/home/xymostech/.local/share/Steam/*" \
    / /media/Backup
