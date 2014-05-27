#!/usr/bin/env bash

muted=$(pacmd dump | grep "set-sink-mute" | awk '{print $3}')

if [ $muted == "yes" ]
then
    pacmd set-sink-mute 0 0
else
    pacmd set-sink-mute 0 1
fi
