#!/bin/bash

# add additional repositories

# docker
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

# atom
wget -qO - https://packagecloud.io/AtomEditor/atom/gpgkey | sudo apt-key add -
sudo add-apt-repository \
    "deb [arch=amd64] https://packagecloud.io/AtomEditor/atom/any/ \
    any \
    main"

# virtualbox
wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
sudo add-apt-repository \
    "deb [arch=amd64] https://download.virtualbox.org/virtualbox/debian \
    $(lsb_release -cs) \
    contrib"

# update and install from new repos plus additional standard packages
sudo apt update

sudo apt install \
    docker-ce \
    docker-ce-cli \
    containerd.io \
    atom \
    virtualbox \
    ack \
    build-essential \
    cmake \
    tilix \
    virtualenv

# copy config, update atom packages, install extras
if [ ! -d ~/.atom ]; then
    mkdir ~/.atom
fi

if [ -f config.cson ]; then
    cp config.cson ~/.atom/
fi

apm update
apm install \
    atom-ide-ui \
    atom-material-syntax \
    atom-material-syntax-dark \
    atom-material-ui \
    docker \
    ide-json \
    language-jenkinsfile \
    linter \
    linter-docker \
    linter-kubectl \
    platformio-ide-terminal
