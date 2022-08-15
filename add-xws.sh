#!/bin/bash
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
MYIP=$(wget -qO- ifconfig.co);
echo "Checking VPS"
#EDIT IZIN
clear
domain=$(cat /etc/v2ray/domain)
svr="DG VMESS01"
tls="$(cat ~/log-install.txt | grep -w "Xray Vmess TLS" | cut -d: -f2|sed 's/ //g')"
none="$(cat ~/log-install.txt | grep -w "Xray Vmess None TLS" | cut -d: -f2|sed 's/ //g')"
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${CLIENT_EXISTS} == '0' ]]; do
		read -rp "User: " -e user
		CLIENT_EXISTS=$(grep -w $user /usr/local/etc/xray/config.json | wc -l)

		if [[ ${CLIENT_EXISTS} == '1' ]]; then
			echo ""
			echo "A client with the specified name was already created, please choose another name."
			exit 1
		fi
	done

echo -ne "Custom UUID [press enter for random] : "
read uuid
[[ -z $uuid ]] && uuid=$(cat /proc/sys/kernel/random/uuid)
read -p "Expired (days): " masaaktif
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
sed -i '/#tls$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","alterId": '"2"',"email": "'""$user""'"' /usr/local/etc/xray/config.json
sed -i '/#none$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","alterId": '"2"',"email": "'""$user""'"' /usr/local/etc/xray/none.json
cat>/usr/local/etc/xray/$user-tls.json<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${domain}",
      "port": "${tls}",
      "id": "${uuid}",
      "aid": "2",
      "net": "ws",
      "path": "/xray",
      "type": "none",
      "host": "",
      "tls": "tls"
}
EOF
cat>/usr/local/etc/xray/$user-none.json<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "cf.ctechdidik.me",
      "port": "${none}",
      "id": "${uuid}",
      "aid": "2",
      "net": "ws",
      "path": "/xray",
      "type": "none",
      "host": "dgrb.dbproject.xyz",
      "tls": "none"
}
EOF

vd1="vless://${uuid}@${bug1}.${domain}:$none?path=/xray&encryption=none&host=${bug1}&type=ws#vless_${svr}_xray_${user}"
vmess_base641=$( base64 -w 0 <<< $vmess_json1)
vmess_base642=$( base64 -w 0 <<< $vmess_json2)
vmesslink1="vmess://$(base64 -w 0 /usr/local/etc/xray/$user-tls.json)"
vmesslink2="vmess://$(base64 -w 0 /usr/local/etc/xray/$user-none.json)"
systemctl restart xray
systemctl restart xray@none
service cron restart
clear
echo -e ""
echo -e "━━━━━━━━━━━━━━━━"
echo -e "XRay VMess Account Information"
echo -e "━━━━━━━━━━━━━━━━"
echo -e "Host : Vless ${svr}"
echo -e "Username : ${user}"
echo -e "Vless ID : ${uuid}"
echo -e "Active Time : $masaaktif"
echo -e "Expiration Date : $exp"
echo -e "━━━━━━━━━━━━━━━━"
echo -e "Anda boleh terus menggunakan config lama."
echo -e "Terima kasih"
echo -e "━━━━━━━━━━━━━━━━"
echo -e ""
echo -e "${vmesslink2}"
echo -e ""
