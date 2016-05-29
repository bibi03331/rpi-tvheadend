docker run -d \
  --name rpi-tvheadend \
  -p 9981:9981 \
  -p 9982:9982 \
  -v /root/persistent/rpi-tvheadend/config:/config \
  -v /root/persistent/rpi-tvheadend/records:/records \
  --privileged \
  rpi-tvheadend-v1
