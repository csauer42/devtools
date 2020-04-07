#!/bin/bash

# add additional repositories for embedded dev

# make sure we're up to date
sudo apt update
sudo apt upgrade

sudo apt install \
    avr-libc \
    avrdude \
    gcc-avr \
    hexdiff \
    pulseview \
    sigrok

# stm32 packages?
# rpi?
