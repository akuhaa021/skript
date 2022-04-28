#!/bin/bash
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
MYIP=$(wget -qO- ifconfig.me/ip);
echo "Checking VPS"
#EDIT IZIN

clear
bugdigi1=/root/.ctech/.kumbang/digi1
bugdigi2=/root/.ctech/.kumbang/digi2
bugdigi3=/root/.ctech/.kumbang/digi3
bugumobile1=/root/.ctech/.kumbang/umobile1
bugumobile2=/root/.ctech/.kumbang/umobile2
bugumobile3=/root/.ctech/.kumbang/umobile3
bugmaxis1=/root/.ctech/.kumbang/maxis1
bugmaxis2=/root/.ctech/.kumbang/maxis2
bugmaxis3=/root/.ctech/.kumbang/maxis3
installed=/root/.ctech/.kumbang/install
done=$(cat $installed | grep -w "done" | wc -l)
if [[ ${done} == '1' ]]; then
    echo -ne "BUG DIGI 1: "
    read bug_digi
    echo "$bug_digi" >$bugdigi1
    echo -ne "BUG DIGI 2: "
    read bug_digi
    echo "$bug_digi" >$bugdigi2
    echo -ne "BUG Digi 3 : "
    read bug_digi
    echo "$bug_digi" >$bugdigi3
    echo -ne "BUG UMOBILE 1 : "
    read bug_digi
    echo "$bug_digi" >$bugumobile1
    echo -ne "BUG UMOBILE 2 : "
    read bug_digi
    echo "$bug_digi" >$bugumobile2
    echo -ne "BUG UMOBILE 3 : "
    read bug_digi
    echo "$bug_digi" >$bugumobile3
    echo -ne "BUG MAXIS 1 : "
    read bug_digi
    echo "$bug_digi" >$bugumaxis1
    echo -ne "BUG MAXIS 2 : "
    read bug_digi
    echo "$bug_digi" >$bugmaxis2
    echo -ne "BUG MAXIS 3 : "
    read bug_digi
    echo "$bug_digi" >$bugmaxis3

else
mkdir /root/.ctech
mkdir /root/.ctech/.kumbang
echo 'ctechdidik.me' >$bugdigi1
echo 'ctechdidik.me' >$bugdigi2
echo 'ctechdidik.me' >$bugdigi3
echo 'ctechdidik.me' >$bugumobile1
echo 'ctechdidik.me' >$bugumobile2
echo 'ctechdidik.me' >$bugumobile3
echo 'ctechdidik.me' >$bugmaxis1
echo 'ctechdidik.me' >$bugmaxis2
echo 'ctechdidik.me' >$bugmaxis3
echo 'done' >$installed
clear
kumbang
fi

read -n 1 -s -r -p "Press any key to back on menu"
menu