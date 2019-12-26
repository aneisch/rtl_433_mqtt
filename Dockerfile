FROM alpine:latest

RUN sed -i 's/http\:\/\/dl-cdn.alpinelinux.org/https\:\/\/alpine.global.ssl.fastly.net/g' /etc/apk/repositories

RUN apk add --update \
    mosquitto-clients openssl curl \
    bash build-base gcc cmake git \
    libusb-dev

RUN apk add --no-cache --virtual build-deps alpine-sdk cmake git libusb-dev && \
    mkdir /tmp/src && \
    cd /tmp/src && \
    git clone https://github.com/steve-m/librtlsdr.git && \
    mv librtlsdr rtl-sdr && \
    mkdir /tmp/src/rtl-sdr/build && \
    cd /tmp/src/rtl-sdr/build && \
    cmake ../ -DINSTALL_UDEV_RULES=ON -DDETACH_KERNEL_DRIVER=ON -DCMAKE_INSTALL_PREFIX:PATH=/usr/local && \
    make && \
    make install && \
    chmod +s /usr/local/bin/rtl_* && \
    cd /tmp/src/ && \
    git clone https://github.com/merbanan/rtl_433 && \
    cd rtl_433/ && \
    mkdir build && \
    cd build && \
    cmake ../ && \
    make && \
    make install && \
    apk del build-deps && \
    rm -r /tmp/src

ENV MQTT_SERVER 10.0.1.22
ENV MQTT_PORT 1883
ENV TOPIC sensor/thermopro
ENV RTL_433_DEVICE 97
    
ENTRYPOINT rtl_433 -F "mqtt://MQTT_SERVER:$MQTT_PORT,events=$TOPIC" -R "$RTL_433_DEVICE"
