FROM lsiobase/ubuntu:bionic

# set environment variables
ARG DEBIAN_FRONTEND="noninteractive"
ENV XDG_CONFIG_HOME="/config/xdg" \
    DISPLAY=":0.0" \
    LANG="en_US.UTF-8" \
    LANGUAGE="en_US.UTF-8" \
    LC_ALL="C.UTF-8" \
    NO_VNC_HOME="/opt/novnc"

RUN \
 echo "**** install dependencies ****" && \
 apt-get update && \
 apt-get install -y --no-install-recommends gnupg x11vnc xvfb fluxbox && \
 echo "**** add retroshare repository ****" && \
 apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 0DCC231C3A9D71D19E719486AEFCFCD4144729B5 && \
 echo "deb http://ppa.launchpad.net/retroshare/stable/ubuntu bionic main" > \
    /etc/apt/sources.list.d/retroshare.list && \
 echo "**** install retroshare ****" && \
 apt-get update && \
 apt-get install -y retroshare && \
 echo "**** cleanup ****" && \
 apt-get clean && \
 rm -rf \
    /tmp/* \
    /var/lib/apt/lists/* \
    /var/tmp/*

COPY root/ /

VOLUME /config
