
## Wiring

![Wiring Diagram with NPN Transistor ](/IMG/IMG_5906.png)

## Create or download fan_control.sh
You can create your own or download directly from rep. You should give +x perm.

 ```bash 
sudo chmod +x /usr/local/bin/fan_control.sh
  ```
```bash
#!/bin/bash

# Yol değişkeni
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/root/fan.sh

# GPIO pini ayarla
GPIO_PIN=21
TEMP_THRESHOLD=50000

# GPIO pinini çıkış olarak ayarla
gpio mode $GPIO_PIN out

# GPIO pini sıfırla (fanı kapat)
gpio write $GPIO_PIN 0

# Sürekli sıcaklık kontrolü
while true; do
    CURRENT_TEMP=$(cat /sys/class/thermal/thermal_zone0/temp)
    
    if [[ $CURRENT_TEMP -gt $TEMP_THRESHOLD ]]; then
        gpio write $GPIO_PIN 1  # Fanı aç
        sleep 1m  # 1 dakika bekle
    else
        gpio write $GPIO_PIN 0  # Fanı kapat
    fi

    sleep 5  # 5 saniye bekle ve tekrar kontrol et
done
```

## Creating systemd Services
Create a systemd service file. Save this in /etc/systemd/system/fan_control.service:
 ```bash 
  sudo nano /etc/systemd/system/fan_control.service
  ```
 ```bash 
[Unit]
Description=Fan Control Service
After=network.target

[Service]
ExecStart=/usr/local/bin/fan_control.sh
Restart=always
User=root

[Install]
WantedBy=multi-user.target


```
### Start systemd Service

 ```bash 
sudo systemctl daemon-reload
sudo systemctl enable fan_control.service
sudo systemctl start fan_control.service
```
