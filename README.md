
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

![Wiring Diagram with NPN Transistor ](github.com/devreyakan/Simple_SBC_Fan_Control/blob/main/IMG/IMG_5906.png)

  
