# RTL_433 Thermopro MQTT container

By default, listens for temperature messages from Thermopro and
publishes to MQTT. Can be configured to listen for other device broadcasts. 

## Usage

### Example docker-compose

```yaml
version: '3.2'
services:
    thermopro_mqtt:
        container_name: thermopro_mqtt
        image: aneisch/rtl_433_mqtt:latest
        environment:
          - MQTT_SERVER=10.0.1.22
          - MQTT_PORT=1883
          - TOPIC=sensor/thermopro
          # 97 = Thermopro https://github.com/merbanan/rtl_433/blob/master/README.md
          - RTL_433_DEVICE=97
        restart: 'no'
        devices:
          - '/dev/rtl_433:/dev/bus/usb/003/002'
```

