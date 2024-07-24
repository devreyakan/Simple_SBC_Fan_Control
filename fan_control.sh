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
