#!/bin/bash

#Добавление источников для установки программ
function source_check(){
	for source in $( ls -l /etc/apt/sources.list ); do
		if [[ -e $source ]]; then
			echo "deb http://deb.debian.org/debian bookworm main
deb http://deb.debian.org/debian bookworm-updates main
deb http://security.debian.org/debian-security bookworm-security main
deb http://ftp.debian.org/debian bookworm-backports main" > $source
		fi
	done
}

#Проверка и установка необходимых программ
function app_check_inst(){
	for list in `cat /IaC/applist`; do
		for i in $( apt list | grep -w $list | awk '{print $1}'  ); do
			if [[ -z $i ]]; then
			 	apt update
				apt -y install $i
				else echo -e "Программа $i установлена"
			fi
	done 2>/dev/null
done 2>/dev/null
}

#Создание пользователя для ssh соединений и настройка sshd
function add_user_and_sshd_conf(){
	echo Введите пароль для нового пользователя sshuser
	read usr_pass
	useradd -m -p $usr_pass -s /bin/bash sshuser
	if [[ -f /etc/ssh/sshd_config ]]; then
		sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config
		sed -i 's/#Port 22/Port 22/g' /etc/ssh/sshd_config
	fi
	runuser sshuser -c "ssh-keygen -q -t rsa -N 'IB' -f /home/sshuser/.ssh/id_rsa <<<y >/dev/null 2>&1"
}
function MAIN(){
	source_check
	app_check_inst
	add_user_and_sshd_conf
	reboot
}
MAIN