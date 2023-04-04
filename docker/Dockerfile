# This Docker image is based on Ubuntu
ARG BASE=ubuntu:20.04
FROM richardwiden/mimersql:latest as v110

# This Docker image is based on Ubuntu

FROM ${BASE}
STOPSIGNAL SIGINT

# update and install necessary utilities
RUN apt-get update && \
    apt-get install -y wget procps file sudo  && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*


# set the name of the package
ARG MIM_MAIN_VER=mimersql1016
ARG MIM_SPECIFIC_VER=10.1.6D
ARG MIM_TAG=36610_amd64
ARG DEBFILE=${MIM_MAIN_VER}_${MIM_SPECIFIC_VER}-${MIM_TAG}.deb
ARG MIM_DIR=${MIM_MAIN_VER}-${MIM_SPECIFIC_VER}

# fetch the package and install it
RUN wget -nv -O ${DEBFILE} https://download.mimer.com/pub/dist/linux_x64/${DEBFILE} &&\
    dpkg --ignore-depends=zenity --install ${DEBFILE} &&\
    rm ${DEBFILE} \
COPY --from=v110 /opt/mimersqlsrv1107-11.0.7A/bin/mimchval /opt/${MIM_DIR}/bin/mimchval

# copy the start script and launch Mimer SQL
COPY start.sh /
RUN chmod +x /start.sh
ENTRYPOINT ["/bin/sh","/start.sh"]
