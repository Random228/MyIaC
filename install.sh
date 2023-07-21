#!/bin/bash

if [[ `whoami` = "root" ]]; then 
mkdir /IaC
wget --progress=bar -c --directory-prefix=/IaC https://github.com/Random228/MyIaC/blob/main/iac.sh 
wget --progress=bar -c --directory-prefix=/IaC https://github.com/Random228/MyIaC/blob/main/applist
bash /IaC/iac.sh
else echo -E "Скрипт необходимо запускать под пользователем root"
fi