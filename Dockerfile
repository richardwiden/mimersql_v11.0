# This Docker image is based on Ubuntu
FROM ubuntu:20.04

# update and install necessary utilities
RUN apt-get update && \
    apt-get install -y wget procps file sudo && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# set the name of the package
ARG MIMVERSION=mimersqlsrv1106_11.0.6C
ARG DEBFILE=${MIMVERSION}-37151_amd64.deb
ARG BASE_URL=http://ftp.mimer.com/pub/beta/linux_x86_64

# fetch the package and install it
RUN wget -nv -o {DEBFILE} ${BASE_URL}/${DEBFILE} && \
    dpkg --install ${DEBFILE} && \
    rm ${DEBFILE}

STOPSIGNAL SIGINT

# copy the start script and launch Mimer SQL
COPY start.sh /
RUN chmod +x /start.sh
ENTRYPOINT ["/bin/sh","/start.sh"]
