#!/bin/bash

if [ $EUID -ne 0 ]
then
    echo "please run as root"
    exit 1
fi

zdm_path="https://www.zconverter.com/zdm/install.sh"


if which wget
then
    echo "wget already exists."
else
    echo "wget does not exist."
    sudo apt-get -y update > /tmp/zdm_install.log
    sudo apt-get -y install wget >> /tmp/zdm_install.log
    if [ $? -ne 0 ]; then
        echo "ERROR : wget install failed."
        exit 1
    fi
fi
mkdir -p /
sudo wget -P /tmp/ $zdm_path --no-check-certificate >> /tmp/zdm_install.log
if [ $? -ne 0 ]; then
    echo "ERROR : ZDM download failed."
    exit 1
fi
sudo iptables -F
sudo bash -C /tmp/install.sh -n -l -d 127.0.0.1 >> /tmp/zdm_install.log
if [ $? -ne 0 ]; then
    echo "ERROR : ZDM install failed."
    exit 1
else
    echo "success"
fi