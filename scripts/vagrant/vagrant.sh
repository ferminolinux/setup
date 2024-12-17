#!/usr/bin/env bash

debian() {
    apt-get install -y python3-pip &
    wait
    pip3 install pipx &
    wait
    pipx install ansible &
    wait
    pipx install ansible-core &
    wait
    pipx ensurepath
    ansible --version
}

check_os_family() {
    apt-get install -y curl
    os_family="$(curl -qs https://raw.githubusercontent.com/ferminolinux/setup/refs/heads/main/scripts/utils/check_os_family.sh | bash)"
    echo $os_family
}

case "$(check_os_family)" in 
    debian)
        debian 
        ;;
esac