FROM resin/rpi-raspbian

MAINTAINER Sebastien LAPORTE

RUN apt-get update && apt-get install -y nano git openssl build-essential python-dev libssl-dev pkg-config gettext liburiparser-dev libnss-mdns bzip2 wget cmake

# Compile tvheadend from master
RUN git config --global http.sslVerify false
RUN cd /tmp && git clone https://github.com/tvheadend/tvheadend.git && cd /tmp/tvheadend && ./configure && make && make install && cd / && rm -rf /tmp/tvheadend

# Config directory, should be persisted
VOLUME ["/config"]

# Records directory, for video recorder and timeshif
VOLUME ["/records"]

# HTTP port (web interface)
EXPOSE 9981

# HTSP port (stream)
EXPOSE 9982

ENTRYPOINT ["/usr/local/bin/tvheadend"]
CMD ["-c", "/config"]
