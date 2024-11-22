#!/usr/bin/env bash

declare -r SCRIPT_NAME="$(echo ${0%.*} | basename)"

check_os_family() {
    os_family="$(curl -qs https://raw.githubusercontent.com/ferminolinux/setup/refs/heads/main/scripts/utils/check_os_family.sh | bash)"
    echo $os_family
}

debian() {
    # $1 virtualbox version

    declare version_codename=$(cat /etc/os-release | grep "VERSION_CODENAME" | cut -d '=' -f2)
    declare repo="deb [arch=amd64 signed-by=/usr/share/keyrings/oracle-virtualbox-2016.gpg] https://download.virtualbox.org/virtualbox/debian ${version_codename} contrib"
    declare vb_version="$1"

    echo "Configurando o repositório..."

    echo "${repo}" | tee "/etc/apt/sources.list.d/virtualbox-${version_codename}.list"
    wget -O- https://www.virtualbox.org/download/oracle_vbox_2016.asc | sudo gpg --yes --output /usr/share/keyrings/oracle-virtualbox-2016.gpg --dearmor

    echo "Atualizando os pacotes"
    apt-get update -y &> "/var/log/${SCRIPT_NAME}/update.log" &
    wait

    echo "Instalando pacotes"
    apt-get install -y "virtualbox-${vb_version}" "linux-headers-$(uname -r)"  &> "/var/log/${SCRIPT_NAME}/install.log" &
    wait

    echo "Configurando os modulos do kernel"
    vboxconfig &> "/var/log/${SCRIPT_NAME}/vboxconfig.log" &
    wait
}

declare vb_version 

[[ $# -eq 0 ]] && vb_version="7.0" || vb_version="${1}"

mkdir -p "/var/log/${SCRIPT_NAME}"

case "$(check_os_family)" in
    debian)
        debian "${vb_version}"
        ;; 
esac


