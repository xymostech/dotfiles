#!/usr/bin/env bash

set -euxo pipefail

sleep 0.4

read -r X Y W H < <(slop -f "%x %y %w %h
")

mkvfile=$(mktemp --suffix ".mkv" "/tmp/screengif-XXXXXX")
palettefile=$(mktemp --suffix ".png" "/tmp/screengif-XXXXXX")
datefile=/home/xymostech/screenshots/screen_$(date +"%y-%m-%d_%H:%M:%S").gif

filters="fps=15"

ffmpeg -f x11grab -s "$W"x"$H" -r 60 -i ":0.0+$X,$Y" -c:v ffvhuff -an -y "$mkvfile"

ffmpeg -v warning -i "$mkvfile" -vf "$filters,palettegen" -y "$palettefile"
ffmpeg -v warning -i "$mkvfile" -i "$palettefile" -lavfi "$filters [x]; [x][1:v] paletteuse" -y "$datefile"
rm "$mkvfile"
echo "$mkvfile"
rm "$palettefile"
