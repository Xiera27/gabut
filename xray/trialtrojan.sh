domain=$(cat /etc/xray/domain)
masaaktif=1
Quota=5
user=Trial-TR`</dev/urandom tr -dc 0-9 | head -c3`
clear
uuid=$(cat /proc/sys/kernel/random/uuid)
exp=$(date -d "$masaaktif days" +"%Y-%m-%d")
tgl=$(date -d "$masaaktif days" +"%d")
bln=$(date -d "$masaaktif days" +"%b")
thn=$(date -d "$masaaktif days" +"%Y")
expe="$tgl $bln, $thn"
tgl2=$(date +"%d")
bln2=$(date +"%b")
thn2=$(date +"%Y")
tnggl="$tgl2 $bln2, $thn2"
sed -i '/#trojanws$/a\#! '"$user $exp"'\
},{"password": "'""$uuid""'","email": "'""$user""'"' /etc/xray/config.json
sed -i '/#trojangrpc$/a\#! '"$user $exp"'\
},{"password": "'""$uuid""'","email": "'""$user""'"' /etc/xray/config.json
# Link Trojan Akun
systemctl restart xray
trojanlink1="trojan://${uuid}@${domain}:443?mode=gun&security=tls&type=grpc&serviceName=trojan-grpc&sni=bug.com#${user}"
trojanlink="trojan://${uuid}@bugkamu.com:443?path=%2Ftrojan-ws&security=tls&host=${domain}&type=ws&sni=${domain}#${user}"

cat >/var/www/html/trojan-$user.txt <<-END
◇━━━━━━━━━━━━━━━━━◇
  G E O  P R O J E C T 
◇━━━━━━━━━━━━━━━━━◇
 https://github.com/jaka1m/project
◇━━━━━━━━━━━━━━━━━◇
# Format Trojan GO/WS

- name: Trojan-$user-GO/WS
  server: ${domain}
  port: 443
  type: trojan
  password: ${uuid}
  network: ws
  sni: ${domain}
  skip-cert-verify: true
  udp: true
  ws-opts:
    path: /trojan-ws
    headers:
        Host: ${domain}

# Format Trojan gRPC

- name: Trojan-$user-gRPC
  type: trojan
  server: ${domain}
  port: 443
  password: ${uuid}
  udp: true
  sni: ${domain}
  skip-cert-verify: true
  network: grpc
  grpc-opts:
    grpc-service-name: trojan-grpc

◇━━━━━━━━━━━━━━━━━◇
Link Akun Trojan 
◇━━━━━━━━━━━━━━━━━◇
Link WS          : 
${trojanlink}
◇━━━━━━━━━━━━━━━━━◇
Link GRPC        : 
${trojanlink1}
◇━━━━━━━━━━━━━━━━━◇

END

service cron restart
trojanlink="trojan://${uuid}@${domain}:443?path=%2Ftrojan-ws&security=tls&host=${domain}&type=ws&sni=${domain}#${user}"
trojanlink1="trojan://${uuid}@${domain}:443?mode=gun&security=tls&type=grpc&serviceName=trojan-grpc&sni=${domain}#${user}"
if [ ! -e /etc/trojan ]; then
  mkdir -p /etc/trojan
fi

if [ -z ${Quota} ]; then
  Quota="0"
fi

c=$(echo "${Quota}" | sed 's/[^0-9]*//g')
d=$((${c} * 1024 * 1024 * 1024))

if [[ ${c} != "0" ]]; then
  echo "${d}" >/etc/trojan/${user}
fi
DATADB=$(cat /etc/trojan/.trojan.db | grep "^###" | grep -w "${user}" | awk '{print $2}')
if [[ "${DATADB}" != '' ]]; then
  sed -i "/\b${user}\b/d" /etc/trojan/.trojan.db
fi
echo "### ${user} ${exp} ${uuid}" >>/etc/trojan/.trojan.db
curl -s --max-time $TIMES -d "chat_id=$CHATID&disable_web_page_preview=1&text=$TEXT&parse_mode=html" $URL
clear
echo -e "\033[1;93m◇━━━━━━━━━━━━━━━━━◇\033[0m"
echo -e " CREATE TROJAN ACCOUNT          "
echo -e "\033[1;93m◇━━━━━━━━━━━━━━━━━◇\033[0m"
echo -e "Remarks          : ${user}" 
echo -e "Host/IP          : ${domain}"
#echo -e "User Quota       : ${Quota} GB"
echo -e "port             : 400-900" 
echo -e "Key              : ${uuid}" 
echo -e "Path             : /trojan-ws" 
echo -e "ServiceName      : trojan-grpc" 
echo -e "\033[0;34m◇━━━━━━━━━━━━━━━━━◇\033[0m" 
echo -e "Link WS          : ${trojanlink}" 
echo -e "\033[0;34m◇━━━━━━━━━━━━━━━━━◇\033[0m" 
echo -e "Link GRPC        : ${trojanlink1}" 
echo -e "\033[0;34m◇━━━━━━━━━━━━━━━━━◇\033[0m" 
echo -e "Format OpenClash : https://${domain}:81/trojan-$user.txt" 
echo -e "\033[0;34m◇━━━━━━━━━━━━━━━━━◇\033[0m" 
echo -e "Aktif Selama     : $masaaktif Hari"
echo -e "Dibuat Pada      : $tnggl"
echo -e "Berakhir Pada    : $expe"
echo -e "\033[0;34m◇━━━━━━━━━━━━━━━━━◇\033[0m" 
echo "" 
read -n 1 -s -r -p "Press any key to back on menu"
menu
fi
