#
# makemkv Dockerfile
#
# https://github.com/jlesage/docker-makemkv
#

# Pull base image.
#FROM jlesage/baseimage-gui:alpine-3.6-v2.0.8
FROM ubuntu:17.04

# Define working directory.
#WORKDIR /tmp

# Install MakeMKV.
#ADD makemkv-builder/makemkv.tar.gz /

# Install dependencies.
#RUN \
#    apt install \
#        wget \
#        sed \
#        findutils \
#        util-linux \
#        openjdk8-jre-base

RUN \
    apt install \
    build-essential \
    pkg-config \
    libc6-dev \
    libssl-dev \
    libexpat1-dev \
    libavcodec-dev \
    libgl1-mesa-dev \
    libqt4-dev

# Generate and install favicons.
#RUN \
#    APP_ICON_URL=https://raw.githubusercontent.com/jlesage/docker-templates/master/jlesage/images/makemkv-icon.png && \
#    install_app_icon.sh "$APP_ICON_URL"

RUN \
    wget http://www.makemkv.com/download/makemkv-bin-1.10.7.tar.gz \
    wget http://www.makemkv.com/download/makemkv-oss-1.10.7.tar.gz

RUN \
    tar -xvzf makemkv-bin-1.10.7.tar.gz \
    tar -xvzf makemkv-oss-1.10.7.tar.gz

RUN cd makemkv-oss-1.10.7 \
    ./configure \
    make \
    make install

RUN cd makemkv-bin-1.10.7 \
    make \
    make install



# Add files.
#COPY rootfs/ /

# Update the default configuration file with the latest beta key.
#RUN /opt/makemkv/bin/makemkv-update-beta-key /defaults/settings.conf

# Set environment variables.
ENV APP_NAME="MakeMKV" \
    MAKEMKV_KEY="BETA"

# Define mountable directories.
VOLUME ["/config"]
VOLUME ["/storage"]
VOLUME ["/output"]
VOLUME ["/watch"]

# Metadata.
LABEL \
      org.label-schema.name="makemkv" \
      org.label-schema.description="Docker container for MakeMKV" \
      org.label-schema.version="unknown" \
      org.label-schema.vcs-url="https://github.com/jlesage/docker-makemkv" \
      org.label-schema.schema-version="1.0"
