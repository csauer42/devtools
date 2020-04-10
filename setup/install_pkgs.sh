#!/bin/bash

# add additional repositories

# make sure we're up to date
sudo apt update
sudo apt upgrade

# docker
sudo apt install \
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
    virtualbox-ext-pack \
    ack \
    build-essential \
    cmake \
    diffstat \
    fonts-inconsolata \
    fonts-ricty-diminished \
    geany \
    htop \
    minicom \
    net-tools \
    nfs-server \
    nmap \
    taskwarrior \
    tilix \
    virtualenv \
    vlc \
    wireshark \
    xinetd

# get docker-compose
DC_VER="1.25.4"
sudo curl -L \
 "https://github.com/docker/compose/releases/download/$DC_VER/docker-compose-$(uname -s)-$(uname -m)" \
 -o /usr/local/bin/docker-compose
sudo chmod 755 /usr/local/bin/docker-compose


# fix tilix vte issue
if [ ! -f /etc/profile.d/vte.sh ]; then
    if [ -f /etc/profile.d/vte-2.91.sh ]; then
        sudo ln -sf /etc/profile.d/vte-2.91.sh /etc/profile.d/vte.sh
    fi
fi

echo -ne 'if [ $TILIX_ID ] || [ $VTE_VERSION ]; then\n    source /etc/profile.d/vte.sh\nfi\n' >> ~/.bashrc

# configure tilix
if [ -f tilix.conf ]; then
    dconf load /com/gexperts/Tilix/ < tilix.conf
fi

# fix terminal prompt
sed -i 's/\(^    PS1.*\\\)w/\1W/' ~/.bashrc

# add user to additional groups
sudo usermod -aG docker $USER
sudo usermod -aG dialout $USER
sudo usermod -aG wireshark $USER

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
