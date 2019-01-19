FROM ubuntu:18.04

ENV DEBIAN_FRONTEND noninteractive

LABEL description="An Ubuntu 18.04 image with tools needed for building crwapache plugin."

# SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN \
apt-get update && \
apt-get --yes -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" \
    install \
        sudo \
        apache2 \
        apache2-dev \
        apt-transport-https \
        autoconf \
        automake \
        build-essential \
        curl \
        devscripts \
        equivs \
        g++ \
        gcc \
        git \
        language-pack-en-base \
        libapr1-dev \
        libaprutil1-dev \
        libcurl4-gnutls-dev \
        libsvn-dev \
        libsvn1 \
        libtool \
        libxml2-dev \
        locales \
        make \
        software-properties-common \
        tzdata
