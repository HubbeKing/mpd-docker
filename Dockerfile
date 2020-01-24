FROM ubuntu:18.04

RUN apt update && apt install -y mpd mpdscribble gettext-base

# user details
ENV USER=hubbe
ENV UID=1000
ENV GID=1000

# create user
RUN groupadd --gid $GID $USER
RUN useradd --create-home --shell /bin/bash --uid $UID --gid $GID $USER

USER $USER
# create folder structures used by mpd and mpdscribble
RUN mkdir -p /home/$USER/.config/mpd/playlists
RUN mkdir -p /home/$USER/.mpdscribble

# start.sh copies this into .config/mpd folder after running envsubst
COPY mpd.conf /home/$USER/
# start.sh copies this into .mpdscribble folder after running envsubst
COPY mpdscribble.conf /home/$USER/

COPY start.sh /home/$USER/

CMD /home/$USER/start.sh
