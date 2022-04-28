#!/bin/bash
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
MYIP=$(wget -qO- ifconfig.me/ip);
echo "Checking VPS"
#EDIT IZIN
clear
domain=$(cat /etc/v2ray/domain)
tls="$(cat ~/log-install.txt | grep -w "Xray Vless TLS" | cut -d: -f2|sed 's/ //g')"
none="$(cat ~/log-install.txt | grep -w "Xray Vless None TLS" | cut -d: -f2|sed 's/ //g')"
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${CLIENT_EXISTS} == '0' ]]; do
		read -rp "User: " -e user
		CLIENT_EXISTS=$(grep -w $user /usr/local/etc/xray/vless.json | wc -l)

		if [[ ${CLIENT_EXISTS} == '1' ]]; then
			echo ""
			echo "A client with the specified name was already created, please choose another name."
			exit 1
		fi
	done

bugdigi1=/root/.ctech/.kumbang/digi1
bugdigi2=/root/.ctech/.kumbang/digi2
bugdigi3=/root/.ctech/.kumbang/digi3
bugumobile1=/root/.ctech/.kumbang/umobile1
bugumobile2=/root/.ctech/.kumbang/umobile2
bugumobile3=/root/.ctech/.kumbang/umobile3
bugmaxis1=/root/.ctech/.kumbang/maxis1
bugmaxis2=/root/.ctech/.kumbang/maxis2
bugmaxis3=/root/.ctech/.kumbang/maxis3
digi1=$(sed -n '1 p' $bugdigi1 | cut -d' ' -f1)
digi2=$(sed -n '1 p' $bugdigi2 | cut -d' ' -f1)
digi3=$(sed -n '1 p' $bugdigi3 | cut -d' ' -f1)
umo1=$(sed -n '1 p' $bugumobile1 | cut -d' ' -f1)
umo2=$(sed -n '1 p' $bugumobile2 | cut -d' ' -f1)
umo3=$(sed -n '1 p' $bugumobile3 | cut -d' ' -f1)
maxis1=$(sed -n '1 p' $bugmaxis1 | cut -d' ' -f1)
maxis2=$(sed -n '1 p' $bugmaxis2 | cut -d' ' -f1)
maxis3=$(sed -n '1 p' $bugmaxis3 | cut -d' ' -f1)


svr=/root/.svr/nameserver
ns=$(sed -n '1 p' $svr | cut -d' ' -f1)

while true $x != "ok"
do
echo "1. DIGI"
echo "2. UMOBILE"
echo "3. MAXIS"

echo -ne "Input your choice : "; read list
case "$list" in 
   1) bug1="$digi1" bug2="$digi2" bug3="$digi3" ;break;;
   2) bug1="$umo1" bug2="$umo2" bug3="$umo3" ;break;;
   3) bug1="$maxis" bug2="$maxis2" bug3="$maxis3" ;break;;

esac
done

echo -ne "Custom UUID [press enter for random] : "
read uuid
[[ -z $uuid ]] && uuid=$(cat /proc/sys/kernel/random/uuid)

read -p "Expired (days): " masaaktif
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
sed -i '/#tls$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /usr/local/etc/xray/vless.json
sed -i '/#none$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /usr/local/etc/xray/vnone.json
vlesslink1="vless://${uuid}@${domain}:$tls?path=/xray&security=tls&encryption=none&type=ws#${user}"
vlesslink2="vless://${uuid}@${domain}:$none?path=/xray&encryption=none&type=ws#${user}"

vd1="vless://${uuid}@${bug1}.${domain}:$none?path=/xray&encryption=none&host=${bug1}&type=ws#vless_${ns}_xray_${user}"
vd2="vless://${uuid}@${bug2}.${domain}:$none?path=/xray&encryption=none&host=${bug2}&type=ws#vless_${ns}_xray_${user}"
vd3="vless://${uuid}@${bug3}.${domain}:$none?path=/xray&encryption=none&host=${bug3}&type=ws#vless_${ns}_xray_${user}"


systemctl restart xray@vless
systemctl restart xray@vnone
clear

echo -e ""
echo -e "━━━━━━━━━━━━━━━━"
echo -e "XRay Vless Account Information"
echo -e "━━━━━━━━━━━━━━━━"
echo -e "Host : Vless ${ns}"
echo -e "Username : ${user}"
echo -e "Vless ID : ${uuid}"
echo -e "Active Time : $masaaktif"
echo -e "Expiration Date : $exp"
echo -e "━━━━━━━━━━━━━━━━"
echo -e ""
echo -e "${vd1}"
echo -e ""
echo -e "${vd2}"
echo -e ""
echo -e "${vd3}"
echo -e ""
echo -e "================================="
echo -e "Anda boleh terus menggunakan config lama."
echo -e "Terima kasih"

