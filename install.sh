#!/bin/bash

if [[ `whoami` == "root" ]]; then 
mkdir /IaC
wget --progress=bar -c --directory-prefix=/IaC https://raw.githubusercontent.com/Random228/MyIaC/Random/iac.sh
wget --progress=bar -c --directory-prefix=/IaC https://raw.githubusercontent.com/Random228/MyIaC/Random/applist
bash /IaC/iac.sh
else echo "Скрипт необходимо запускать под пользователем root"
fi