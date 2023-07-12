domain=$(cat /etc/xray/domain)
masaaktif=1
Quota=5
user=Trial-VL`</dev/urandom tr -dc 0-9 | head -c3`
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
sed -i '/#vless$/a\#& '"$user $exp"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /etc/xray/config.json
sed -i '/#vlessgrpc$/a\#& '"$user $exp"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /etc/xray/config.json
clear
vlesslink1="vless://${uuid}@${domain}:443?path=/vless&security=tls&encryption=none&type=ws#${user}"
vlesslink2="vless://${uuid}@${domain}:80?path=/vless&encryption=none&type=ws#${user}"
vlesslink3="vless://${uuid}@${domain}:443?mode=gun&security=tls&encryption=none&type=grpc&serviceName=vless-grpc&sni=${domain}#${user}"
cat >/var/www/html/vless-$user.txt <<-END

◇━━━━━━━━━━━━━━━━━◇
  G E O  P R O J E C T 
◇━━━━━━━━━━━━━━━━━◇
 https://github.com/jaka1m/project
◇━━━━━━━━━━━━━━━━━◇
# Format Vless WS TLS

- name: Vless-$user-WS TLS
  server: ${domain}
  port: 443
  type: vless
  uuid: ${uuid}
  cipher: auto
  tls: true
  skip-cert-verify: true
  servername: ${domain}
  network: ws
  ws-opts:
    path: /vless
    headers:
      Host: ${domain}

# Format Vless WS Non TLS

- name: Vless-$user-WS (CDN) Non TLS
  server: ${domain}
  port: 80
  type: vless
  uuid: ${uuid}
  cipher: auto
  tls: false
  skip-cert-verify: false
  servername: ${domain}
  network: ws
  ws-opts:
    path: /vless
    headers:
      Host: ${domain}
  udp: true

# Format Vless gRPC (SNI)

- name: Vless-$user-gRPC (SNI)
  server: ${domain}
  port: 443
  type: vless
  uuid: ${uuid}
  cipher: auto
  tls: true
  skip-cert-verify: true
  servername: ${domain}
  network: grpc
  grpc-opts:
  grpc-mode: gun
    grpc-service-name: vless-grpc

◇━━━━━━━━━━━━━━━━━◇
Link Akun Vless 
◇━━━━━━━━━━━━━━━━━◇
Link TLS      : 
${vlesslink1}
◇━━━━━━━━━━━━━━━━━◇
Link none TLS : 
${vlesslink2}
◇━━━━━━━━━━━━━━━━━◇
Link GRPC     : 
${vlesslink3}
◇━━━━━━━━━━━━━━━━━◇


END

systemctl restart xray
systemctl restart nginx
clear
echo -e "\033[1;93m◇━━━━━━━━━━━━━━━━━◇\033[0m"
echo -e " CREATE VLESS ACCOUNT           "
echo -e "\033[1;93m◇━━━━━━━━━━━━━━━━━◇\033[0m"
echo -e "Remarks     : ${user}"
echo -e "Domain      : ${domain}"
#echo -e "User Quota  : ${Quota} GB"
echo -e "port TLS    : 400-900"
#echo -e "Port DNS    : 443"
echo -e "Port NTLS   : 80, 8080, 8081-9999"
echo -e "User ID     : ${uuid}"
echo -e "Encryption  : none"
echo -e "Path TLS    : /vless "
echo -e "ServiceName : vless-grpc"
echo -e "\033[1;93m◇━━━━━━━━━━━━━━━━━◇\033[0m"
echo -e "Link TLS    : ${vlesslink1}"
echo -e "\033[1;93m◇━━━━━━━━━━━━━━━━━◇\033[0m"
echo -e "Link NTLS   : ${vlesslink2}"
echo -e "\033[1;93m◇━━━━━━━━━━━━━━━━━◇\033[0m"
echo -e "Link GRPC   : ${vlesslink3}"
echo -e "\033[1;93m◇━━━━━━━━━━━━━━━━━◇\033[0m"
echo -e "Format OpenClash : https://${domain}:81/vless-$user.txt"
echo -e "\033[1;93m◇━━━━━━━━━━━━━━━━━◇\033[0m"
echo -e "Aktif Selama     : $masaaktif Hari"
echo -e "Dibuat Pada      : $tnggl"
echo -e "Berakhir Pada    : $expe"
echo -e "\033[1;93m◇━━━━━━━━━━━━━━━━━◇\033[0m"
echo -e ""
read -n 1 -s -r -p "Press any key to back on menu"

menu
