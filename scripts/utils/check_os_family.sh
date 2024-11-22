#!/usr/bin/env bash

check_os_family() {
    os_family=$(cat /etc/os-release | grep "ID_LIKE")
    echo "${os_family}"
}