#!/bin/bash

REPO=registry.hubbe.club/music

buildah bud --tag $REPO:mpd mpd
buildah bud --tag $REPO:mpdscribble mpdscribble
buildah push $REPO:mpd
buildah push $REPO:mpdscribble
