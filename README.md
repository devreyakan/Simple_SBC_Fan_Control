
# Simple SBC Fan Control

This repository contains the code and logic for an automated CPU cooling fan for the Orange Pi PC single-board computer. The fan is controlled based on the CPU temperature, turning on when the temperature reaches a certain threshold and turning off when it falls below another threshold.


## Features

- Automatic fan control based on CPU temperature
- Customizable temperature thresholds
- Easy installation and configuration

  
## Prerequisites

- Orange Pi PC / single-board computer
- WiringOP library
- Python (optional)

  
## Installation
Before the Installation it's recommended to update your system.

 ```bash 
sudo apt-get update
sudo apt-get upgrade
```

### Install WiringOP:


 ```bash 
mkdir downloads
cd downloads
git clone https://github.com/zhaolei/WiringOP.git -b h3
cd WiringOP/
sudo ./build
```

#### Test WiringOP:

```bash 
gpio readall
```
You should see something like this;
```bash 
 +-----+-----+----------+------+---+-Orange Pi+---+---+------+---------+-----+--+
 | BCM | wPi |   Name   | Mode | V | Physical | V | Mode | Name     | wPi | BCM |
 +-----+-----+----------+------+---+----++----+---+------+----------+-----+-----+
 |     |     |     3.3v |      |   |  1 || 2  |   |      | 5v       |     |     |
 |  12 |   8 |    SDA.0 | ALT5 | 0 |  3 || 4  |   |      | 5V       |     |     |
 |  11 |   9 |    SCL.0 | ALT5 | 0 |  5 || 6  |   |      | 0v       |     |     |
 |   6 |   7 |   GPIO.7 | ALT3 | 0 |  7 || 8  | 0 | ALT3 | TxD3     | 15  | 13  |
 |     |     |       0v |      |   |  9 || 10 | 0 | ALT3 | RxD3     | 16  | 14  |
 |   1 |   0 |     RxD2 | ALT3 | 0 | 11 || 12 | 0 | ALT3 | GPIO.1   | 1   | 110 |
 |   0 |   2 |     TxD2 | ALT3 | 1 | 13 || 14 |   |      | 0v       |     |     |
 |   3 |   3 |     CTS2 |   IN | 1 | 15 || 16 | 0 | ALT3 | GPIO.4   | 4   | 68  |
 |     |     |     3.3v |      |   | 17 || 18 | 0 | ALT3 | GPIO.5   | 5   | 71  |
 |  64 |  12 |     MOSI | ALT4 | 0 | 19 || 20 |   |      | 0v       |     |     |
 |  65 |  13 |     MISO | ALT4 | 0 | 21 || 22 | 0 | ALT3 | RTS2     | 6   | 2   |
 |  66 |  14 |     SCLK | ALT4 | 0 | 23 || 24 | 0 | ALT4 | CE0      | 10  | 67  |
 |     |     |       0v |      |   | 25 || 26 | 0 | ALT5 | GPIO.11  | 11  | 21  |
 |  19 |  30 |    SDA.1 | ALT5 | 0 | 27 || 28 | 0 | ALT5 | SCL.1    | 31  | 18  |
 |   7 |  21 |  GPIO.21 |   IN | 1 | 29 || 30 |   |      | 0v       |     |     |
 |   8 |  22 |  GPIO.22 |   IN | 1 | 31 || 32 | 0 | ALT3 | RTS1     | 26  | 200 |
 |   9 |  23 |  GPIO.23 |   IN | 1 | 33 || 34 |   |      | 0v       |     |     |
 |  10 |  24 |  GPIO.24 |   IN | 1 | 35 || 36 | 0 | ALT3 | CTS1     | 27  | 201 |
 |  20 |  25 |  GPIO.25 | ALT5 | 0 | 37 || 38 | 0 | ALT3 | TxD1     | 28  | 198 |
 |     |     |       0v |      |   | 39 || 40 | 0 | ALT3 | RxD1     | 29  | 199 |
 +-----+-----+----------+------+---+----++----+---+------+----------+-----+-----+
 | BCM | wPi |   Name   | Mode | V | Physical | V | Mode | Name     | wPi | BCM |
 +-----+-----+----------+------+---+-Orange Pi+---+------+----------+-----+-----+


```

### (Optional) Install Python if not already installed:

```bash 
sudo apt-get update
sudo apt-get install python3
```
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
