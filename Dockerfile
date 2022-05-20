# This Docker image is based on Ubuntu
FROM richardwiden/mimersql:latest

# This Docker image is based on Ubuntu
ARG BASE=ubuntu:20.04
FROM ${BASE}

# update and install necessary utilities
RUN apt-get update && \
    apt-get install -y wget procps file sudo  && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*


# set the name of the package
ENV MIMVERSION mimersql1016_10.1.6D
ENV DEBFILE ${MIMVERSION}-36610_amd64.deb

# fetch the package and install it
RUN wget -nv -O ${DEBFILE} https://download.mimer.com/pub/dist/linux_x64/${DEBFILE}
RUN dpkg --ignore-depends=zenity --install ${DEBFILE}
COPY --from=v110 /opt/mimersqlsrv1106-11.0.6C/bin/mimchval /opt/${MIMVERSION}/bin/mimchval
STOPSIGNAL SIGINT

# copy the start script and launch Mimer SQL
COPY start.sh /
RUN chmod +x /start.sh
ENTRYPOINT ["/bin/sh","/start.sh"]
