FROM ubuntu:20.04

RUN apt update && apt install -y --no-install-recommends \
    libpulse0 \
    mpd

# user details
ENV USER=hubbe
ENV UID=1000
ENV GID=1000

# create user
RUN groupadd --gid $GID $USER
RUN useradd --create-home --shell /bin/bash --uid $UID --gid $GID $USER
# create folder structure used by mpd
RUN mkdir -p /home/$USER/.config/mpd/playlists

# add mpd config and startup script
# start.sh adds pulseaudio output configuration to the mpd config based on env var PULSEAUDIO_SERVERS
COPY mpd.conf /home/$USER/.config/mpd/
COPY start.sh /home/$USER/

# ensure correct permissions for user files
RUN chown -R ${USER}:${USER} /home/${USER}/

USER $USER
WORKDIR /home/$USER/
CMD ./start.sh
