#!/bin/bash
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
MYIP=$(wget -qO- ifconfig.me/ip);
echo "Checking VPS"
#EDIT IZIN

clear
svr=/root/.svr/nameserver
installed=/root/.svr/install
done=$(cat $installed | grep -w "done" | wc -l)
if [[ ${done} == '1' ]]; then
    echo -ne "Nama Server: "
    read bug_digi
    echo "$bug_digi" >$svr
else
mkdir /root/.svr
echo 'ctechdidik.me' >$svr

echo 'done' >$installed
clear
kumbang
fi

read -n 1 -s -r -p "Press any key to back on menu"
menu
