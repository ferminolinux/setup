#!/usr/bin/env bash

# Executa as opções relacionadas com o Vagrant
vagrant() {
    curl https://raw.githubusercontent.com/ferminolinux/setup/refs/heads/main/scripts/vagrant/vagrant.sh | bash
}


# Verificar qual é a distribuição Linux
# Carregar o script de instalaçãorelaaionado com aquela distro