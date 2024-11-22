#!/usr/bin/env bash

os_family=$(cat /etc/os-release | grep "ID_LIKE" | cut -d '=' -f2)
echo $os_family