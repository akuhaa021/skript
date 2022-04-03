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
uuid=$(cat /proc/sys/kernel/random/uuid)
read -p "Expired (days): " masaaktif
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
sed -i '/#tls$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /usr/local/etc/xray/vless.json
sed -i '/#none$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /usr/local/etc/xray/vnone.json
vlesslink1="vless://${uuid}@${domain}:$tls?path=/xray&security=tls&encryption=none&type=ws#${user}"
vlesslink2="vless://${uuid}@${domain}:$none?path=/xray&encryption=none&type=ws#${user}"

bugdg1="admin.google.com.st.digi.com.my"
bugdg2="st.digi.com.my"
bugdg3="admin.google.vault21.digi.com.my"
bugum11="clubopen.pubgmobile.com"
bugum2="um.gz.net.my"
bugum3="clubopen.pubgmobile.com.music.u.com.my"
bugmx1="watch.viu.com"


vd1="vless://${uuid}@${bugdg1}.${domain}:$none?path=/xray&encryption=none&host=${bugdg1}&type=ws#vless_SG3_xray_Digi_${user}"
vd2="vless://${uuid}@${bugdg2}.${domain}:$none?path=/xray&encryption=none&host=${bugdg2}&type=ws#vless_SG3_xray_Digi_${user}"
vd3="vless://${uuid}@${bugdg3}.${domain}:$none?path=/xray&encryption=none&host=${bugdg3}&type=ws#vless_SG3_xray_Digi_${user}"
vu1="vless://${uuid}@${bugum1}.${domain}:$none?path=/xray&encryption=none&host=${bugum1}&type=ws#vless_SG3_xray_Umobile_${user}"
vu2="vless://${uuid}@${bugum2}.${domain}:$none?path=/xray&encryption=none&host=${bugum2}&type=ws#vless_SG3_xray_Umobile_${user}"
vu3="vless://${uuid}@${bugum3}.${domain}:$none?path=/xray&encryption=none&host=${bugum3}&type=ws#vless_SG3_xray_Umobile_${user}"
vm1="vless://${uuid}@${bugmx1}.${domain}:$none?path=/xray&encryption=none&host=${bugmx1}&type=ws#vless_SG3_xray_Hotlink_${user}"

systemctl restart xray@vless
systemctl restart xray@vnone
clear

echo -e ""
echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e "XRay Vless Account Information"
echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e "Host : Vless SG03"
echo -e "Username : ${user}"
echo -e "Vless ID : ${uuid}"
echo -e "Active Time : $masaaktif"
echo -e "Expiration Date : $exp"
echo -e "================================="
echo -e "${vd1}"
echo -e "${vd2}"
echo -e "${vd3}"
echo -e "================================="
echo -e "${vu1}"
echo -e "${vu2}"
echo -e "${vu3}"
echo -e "================================="
echo -e "${vm1}"
