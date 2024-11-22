#!/usr/bin/env bash

check_os_family() {
    os_family="$(curl -qs https://raw.githubusercontent.com/ferminolinux/setup/refs/heads/main/scripts/utils/check_os_family.sh | bash)"
    echo $os_family
}

debian() {
    # $1 virtualbox version

    version_codename=$(cat /etc/os-release | grep "VERSION_CODENAME" | cut -d '=' -f2)
    repo="deb [arch=amd64 signed-by=/usr/share/keyrings/oracle-virtualbox-2016.gpg] https://download.virtualbox.org/virtualbox/debian ${version_codename} contrib"
    vb_version="$1"

    echo "${repo}" | tee "/etc/apt/sources.list.d/virtualbox-${version_codename}.list"

    wget -O- https://www.virtualbox.org/download/oracle_vbox_2016.asc | sudo gpg --yes --output /usr/share/keyrings/oracle-virtualbox-2016.gpg --dearmor

    apt-get update -y
    apt-get install -y "virtualbox-${vb_version}" "linux-headers-$(uname -r)" 

    vboxconfig    
}

declare vb_version 

[[ $# -eq 0 ]] && vb_version="7.0" || vb_version="${1}"

case "$(check_os_family)" in
    debian)
        debian "${vb_version}"
        ;; 
esac


