FROM resin/armv7hf-debian-qemu

RUN [ "cross-build-start" ]

RUN apt-get update && \
    apt-get install -y  nano \
                        git \
                        openssl \
                        build-essential \
                        python-dev \
                        libssl-dev \
                        pkg-config \
                        gettext \
                        liburiparser-dev \
                        libnss-mdns \
                        bzip2 \
                        wget \
                        cmake \
                        ca-certificates

# Compile tvheadend from master
RUN cd /tmp && \
    git clone https://github.com/tvheadend/tvheadend.git && \
    cd /tmp/tvheadend && \
    ./configure && \
    make && \
    make install && \
    cd / && \
    rm -rf /tmp/tvheadend

RUN apt-get remove -y build-essential && \
    apt-get autoremove -y && \
    apt-get clean

RUN [ "cross-build-end" ]
	
# Config directory, should be persisted
VOLUME ["/config"]

# Records directory, for video recorder and timeshift
VOLUME ["/records"]

# HTTP port (web interface)
EXPOSE 9981

# HTSP port (stream)
EXPOSE 9982

ENTRYPOINT ["/usr/local/bin/tvheadend"]

CMD ["-c", "/config", "-C"]
