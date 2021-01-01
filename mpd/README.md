## MPD in Docker

- When deploying, set the following ENV variables for the container:
    - PULSEAUDIO_SERVERS
        - should be a comma-separated list of IPv4 addresses
- This is so MPD knows where to send audio.
