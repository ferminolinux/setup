#!/usr/bin/env bash

debian() {
    # $1 virtualbox version

    version_codename=$(cat /etc/os-release | grep "VERSION_CODENAME")
    repo="deb [arch=amd64 signed-by=/usr/share/keyrings/oracle-virtualbox-2016.gpg] https://download.virtualbox.org/virtualbox/debian ${version_codename} contrib"
    vb_version="$1"

    echo "${repo}" | tee "/etc/apt/sources.list.d/virtualbox-${version_codename}"

    wget -O- https://www.virtualbox.org/download/oracle_vbox_2016.asc | sudo gpg --yes --output /usr/share/keyrings/oracle-virtualbox-2016.gpg --dearmor

    sudo apt-get update -y
    sudo apt-get install "virtualbox-${vb_version}"
}