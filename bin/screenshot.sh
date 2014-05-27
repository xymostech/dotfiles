#!/usr/bin/env bash

sleep 0.5

name=$(mktemp --suffix ".png" "scrot-XXXXXX")

if scrot -s "$name" -e 'mv $f /tmp/' > /dev/null 2>&1;
then
    /home/xymostech/bin/clip_image "/tmp/$name"
else
    rm $name
fi
