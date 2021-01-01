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

USER $USER
# create folder structure used by mpd
RUN mkdir -p /home/$USER/.config/mpd/playlists

# start.sh copies this into .config/mpd folder and adds pulseaudio TCP configuration
COPY mpd.conf /home/$USER/

COPY start.sh /home/$USER/

CMD /home/$USER/start.sh
