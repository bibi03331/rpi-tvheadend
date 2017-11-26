# TvHeadend server with Docker for Raspberry Pi

## Requirement

 - Docker installed on a Raspberry Pi
 - A DVB adapter
  - supported by tvheadend 
  - supported by your host linux distribution with correct driver

## Installation

### Build

Run a build to create your image :

```bash
docker build -t rpi-tvheadend-v1 .
```

### Configure

Create your own configuration file based on .env.sample.

```bash
mv .env.sample .env
```

Edit this .env file :

```bash
TVHEADEND_IMAGE=<The name of your built image in the first step>
```

### Run

```bash
docker-compose up -d
```

### Configure TvHeadend

- **Port 9981/tcp** is used for the HTTP interface. Go to http://ip:9981/ in a web browser to configure it.
- **Port 9982/tcp** is used for HTSP stream

### Tuner installation

Tuner installation for AverMedia Volar HD Pro Carte TV USB :

```bash
cd /lib/firmware
wget http://xgazza.altervista.org/Linux/DVB/dvb-usb-af9035-02.fw
wget http://www.ite.com.tw/uploads/firmware/v3.6.0.0/dvb-usb-it9135.zip
unzip
dd if=dvb-usb-it9135.fw ibs=1 skip=64 count=8128 of=dvb-usb-it9135-01.fw
dd if=dvb-usb-it9135.fw ibs=1 skip=12866 count=5817 of=dvb-usb-it9135-02.fw
cp dvb-usb-it9135* /lib/firmware/
tail -40 /var/log/kern.log
```
