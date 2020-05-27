FROM ubuntu:20.04

RUN apt update && apt install -y --no-install-recommends \
    gettext-base \
    mpdscribble

# user details
ENV USER=hubbe
ENV UID=1000
ENV GID=1000

# create user
RUN groupadd --gid $GID $USER
RUN useradd --create-home --shell /bin/bash --uid $UID --gid $GID $USER

USER $USER
# create folder for mpdscribble config
RUN mkdir -p /home/$USER/.mpdscribble

# start.sh copies script into right folder after running envsubst
COPY mpdscribble.conf /home/$USER/

COPY start.sh /home/$USER/

CMD /home/$USER/start.sh
