#!/bin/bash

cp /home/$USER/mpd.conf /home/$USER/.config/mpd/mpd.conf

# split $PULSEAUDIO_SERVERS into an array named "pulse_servers"
IFS=, read -r -d '' -a pulse_servers < <(printf '%s,\0' "$PULSEAUDIO_SERVERS")

# add one audio_output block per host to mpd config file

for server in "${pulse_servers[@]}"; do
cat << EOF >> /home/$USER/.config/mpd/mpd.conf

audio_output {
    type    "pulse"
    name    "$server TCP Output"
    server  "$server"
}
EOF

done

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
