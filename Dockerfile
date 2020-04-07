FROM alpine:latest

RUN apk add --no-cache --update libusb-dev
RUN apk add --no-cache -X http://dl-cdn.alpinelinux.org/alpine/edge/testing librtlsdr-dev rtl-sdr
RUN apk add --no-cache --virtual build-deps alpine-sdk gcc build-base cmake git && \
    mkdir /tmp/src && \
    git clone https://github.com/merbanan/rtl_433 && \
    cd rtl_433/ && \
    mkdir build && \
    cd build && \
    cmake ../ && \
    make && \
    make install && \
    apk del build-deps && \
    rm -r /tmp/src

RUN adduser -D rtl_433
USER rtl_433

ENV MQTT_SERVER 10.0.1.22
ENV MQTT_PORT 1883
ENV TOPIC sensor/thermopro
ENV RTL_433_DEVICE 97
    
CMD rtl_433 -F "mqtt://$MQTT_SERVER:$MQTT_PORT,events=$TOPIC" -R "$RTL_433_DEVICE"
