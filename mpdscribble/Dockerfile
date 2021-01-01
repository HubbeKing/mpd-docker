FROM ubuntu:20.04

RUN apt update && apt install -y --no-install-recommends \
    mpdscribble

# user details
ENV USER=hubbe
ENV UID=1000
ENV GID=1000

# create user
RUN groupadd --gid $GID $USER
RUN useradd --create-home --shell /bin/bash --uid $UID --gid $GID $USER

# create folder for mpdscribble config
RUN mkdir -p /home/$USER/.mpdscribble

# add config and startup script
# start.sh adds credentials from env vars to the config
COPY mpdscribble.conf /home/$USER/.mpdscribble/
COPY start.sh /home/$USER/

# ensure permissions are correct for user home
RUN chown -R ${USER}:${USER} /home/${USER}/

USER $USER
WORKDIR /home/$USER/
CMD ./start.sh
