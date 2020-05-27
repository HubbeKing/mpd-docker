#!/bin/bash

envsubst '$PULSEAUDIO_SERVER' < /home/$USER/mpd.conf > /home/$USER/.config/mpd/mpd.conf

mpd --stdout
status=$?
if [ $status -ne 0 ]; then
    echo "Failed to start mpd: $status"
    exit $status
fi

while sleep 30; do
    ps aux | grep mpd | grep -q -v grep
    MPD_STATUS=$?
    if [ $MPD_STATUS -ne 0 ]; then
        echo "mpd has exited."
        exit 1
    fi
done
