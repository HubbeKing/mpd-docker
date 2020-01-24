#!/bin/bash

envsubst '$LASTFM_USER $LASTFM_PASS' < /home/$USER/mpdscribble.conf > /home/$USER/.mpdscribble/mpdscribble.conf
envsubst '$PULSEAUDIO_SERVER' < /home/$USER/mpd.conf > /home/$USER/.config/mpd/mpd.conf

mpd --stdout
status=$?
if [ $status -ne 0 ]; then
    echo "Failed to start mpd: $status"
    exit $status
fi

mpdscribble --log -
status=$?
if [ $status -ne 0 ]; then
    echo "Failed to start mpdscribble: $status"
    exit $status
fi

while sleep 60; do
    ps aux | grep mpd | grep -q -v grep
    MPD_STATUS=$?
    ps aux | grep mpdscribble | grep -q -v grep
    MPDSCRIBBLE_STATUS=$?
    if [ $MPD_STATUS -ne 0 -o $MPDSCRIBBLE_STATUS -ne 0 ]; then
        echo "One of the processes has exited."
        exit 1
    fi
done
