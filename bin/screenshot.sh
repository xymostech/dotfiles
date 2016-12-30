#!/usr/bin/env bash

set -e

sleep 0.4

tmpfile=$(mktemp --suffix ".png" "/tmp/maim-XXXXXX")
datefile=/home/xymostech/screenshots/screen_$(date +"%y-%m-%d_%H:%M:%S").png

if maim -s --hidecursor "$tmpfile"; then
    cp "$tmpfile" "$datefile"
    /home/xymostech/bin/clip_image "$tmpfile"
    rm "$tmpfile"
else
    rm "$tmpfile"
fi

# Maybe useful at some point
# arc upload <file> --json | jq '.[].uri' | grep -o -e '[^/]\+$'
