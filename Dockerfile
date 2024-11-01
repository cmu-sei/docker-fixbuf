FROM debian:11 AS build

# Specify software versions to download
ARG FIXBUF_VERSION=2.5.0

# Pre-reqs:
# curl for downloading
# build-essentials for build tools
# ca-certs to download https
# glib2.0 for fixbuf
RUN apt-get update && apt-get install -y --no-install-recommends \
        curl \
        build-essential \
        ca-certificates \
        libssl-dev \
        libglib2.0-dev \
        && apt-get clean && \
        rm -rf /var/lib/apt/lists/*

RUN mkdir /netsa
WORKDIR /netsa

# Download & Install fixbuf
RUN curl https://tools.netsa.cert.org/releases/libfixbuf-$FIXBUF_VERSION.tar.gz | \
        tar -xz && cd libfixbuf-* && \
        ./configure --prefix=/netsa \
        --with-openssl && \
        make && \
        make install && \
        cd ../ && rm -rf libfixbuf-$FIXBUF_VERSION

FROM debian:11-slim
LABEL maintainer="maheckathorn@cert.org"

RUN mkdir /netsa

RUN apt-get update && apt-get install -y --no-install-recommends \
        libssl1.1 \
        pkg-config \
        libglib2.0-0 \
        && apt-get clean && \
        rm -rf /var/lib/apt/lists/*

ENV PATH=$PATH:/netsa/bin

COPY --from=build /netsa/ /netsa/