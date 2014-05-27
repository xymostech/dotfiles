#!/usr/bin/env bash

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
    / /media/Backup
