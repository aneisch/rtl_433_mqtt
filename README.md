# RTL_433 Thermopro MQTT container
<a href="https://www.buymeacoffee.com/aneisch" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/default-black.png" width="150px" height="35px" alt="Buy Me A Coffee" style="height: 35px !important;width: 150px !important;" ></a><br>

## Usage
Tweak the rtl_433.config.example to your liking and expose it to the container if you wish to override the default settings.

### Example docker-compose

```yaml
version: '3.2'
services:
    thermopro_mqtt:
        container_name: thermopro_mqtt
        image: docker.pkg.github.com/aneisch/rtl_433_mqtt/rtl_433_mqtt:latest
        restart: 'no'
        devices:
          - '/dev/rtl_433:/dev/bus/usb/003/002'
        volumes:
          - '/opt/433_mqtt/rtl_433_config.example:/etc/rtl_433/rtl_433.conf'
```

