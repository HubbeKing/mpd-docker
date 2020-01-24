## MPD in Docker

When deploying, set the following ENV variables for the container:

LASTFM_USER

LASTFM_PASS

PULSEAUDIO_SERVER

Otherwise, mpdscribble will constantly complain, and pulse won't know where to send audio

Alternatively, set CMD to `mpd --no-daemonize --stdout` to just run mpd

You still need to set PULSEAUDIO_SERVER though.
