#!/bin/bash

envsubst '$LASTFM_USER $LASTFM_PASS' < /home/$USER/mpdscribble.conf > /home/$USER/.mpdscribble/mpdscribble.conf

mpdscribble --host $MPD_HOST --port $MPD_PORT --log -
status=$?
if [ $status -ne 0 ]; then
    echo "Failed to start mpdscribble: $status"
    exit $status
fi

while sleep 30; do
    ps aux | grep mpdscribble | grep -q -v grep
    MPDSCRIBBLE_STATUS=$?
    if [ $MPDSCRIBBLE_STATUS -ne 0 ]; then
        echo "mpdscribble has exited."
        exit 1
    fi
done
