#!/usr/bin/env bash

os_family=$(cat /etc/os-release | grep "ID_LIKE")
echo $os_family