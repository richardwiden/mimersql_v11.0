# This Docker image is based on Ubuntu
ARG BASE=ubuntu:20.04
FROM ${BASE}

# update and install necessary utilities
RUN apt-get update && \
    apt-get install -y wget procps file sudo && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# set the name of the package
ARG MIMVERSION=mimersqlsrv1107_11.0.7A
ARG DEBFILE=${MIMVERSION}-38678_amd64-openssl1.deb
ARG BASE_URL=https://download.mimer.com/pub/dist/linux_x86_64/

# fetch the package and install it
RUN wget -nv -o {DEBFILE} ${BASE_URL}${DEBFILE} && \
    dpkg --install ${DEBFILE} && \
    rm ${DEBFILE}

STOPSIGNAL SIGINT

# copy the start script and launch Mimer SQL
COPY start.sh /
RUN chmod +x /start.sh
ENTRYPOINT ["/bin/sh","/start.sh"]
