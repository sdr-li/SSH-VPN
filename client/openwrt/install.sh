#!/bin/sh

source config_redacted

cp template/create_if.sh temp_files/create_if.sh
chmod +x temp_files/create_if.sh
sed -i "s/<VPN_NAME>/$VPN_NAME/g" temp_files/create_if.sh
sed -i "s/<VPN_LOCAL_IP>/$VPN_LOCAL_IP/g" temp_files/create_if.sh
sed -i "s/<VPN_SUBNET>/$VPN_SUBNET/g" temp_files/create_if.sh

cp template/initd temp_files/ssh_vpn_$VPN_NAME
chmod +x temp_files/ssh_vpn_$VPN_NAME
sed -i "s/<VPN_NAME>/$VPN_NAME/g" temp_files/ssh_vpn_$VPN_NAME
sed -i "s/<VPN_SSH_USERNAME>/$VPN_SSH_USERNAME/g" temp_files/ssh_vpn_$VPN_NAME
sed -i "s/<SSH_SERVER_IP>/$SSH_SERVER_IP/g" temp_files/ssh_vpn_$VPN_NAME
sed -i "s/<SSH_SERVER_PORT>/$SSH_SERVER_PORT/g" temp_files/ssh_vpn_$VPN_NAME
sed -i "s/<VPN_LOCAL_IF>/$VPN_LOCAL_IF/g" temp_files/ssh_vpn_$VPN_NAME
sed -i "s/<VPN_REMOTE_IF>/$VPN_REMOTE_IF/g" temp_files/ssh_vpn_$VPN_NAME

cp template/check-if-vpn-ok.sh temp_files/check-if-vpn-ok.sh
chmod +x temp_files/check-if-vpn-ok.sh
sed -i "s/<VPN_NAME>/$VPN_NAME/g" temp_files/check-if-vpn-ok.sh
sed -i "s/<VPN_REMOTE_IP>/$VPN_REMOTE_IP/g" temp_files/check-if-vpn-ok.sh
sed -i "s/<VPN_REMOTE_IP>/$VPN_REMOTE_IP/g" temp_files/check-if-vpn-ok.sh

cp /var/spool/cron/crontabs/root temp_files/crontab
echo "*/10 * * * * /root/ssh_vpn_$VPN_NAME/check-if-vpn-ok.sh" >> temp_files/crontab

cp /etc/rc.local temp_files/rc.local
sed -i "s/exit 0/ /g" temp_files/rc.local
echo "sleep 15" >> temp_files/rc.local
echo "/root/ssh_vpn_$VPN_NAME/create_if.sh" >> temp_files/rc.local
echo "/root/ssh_vpn_$VPN_NAME/check-if-vpn-ok.sh" >> temp_files/rc.local
echo "exit 0" >> temp_files/rc.local

echo "Check if every file was generated ok! if so, type INSTALL"
read input_text
if [ "$input_text" = "INSTALL" ]; then
    echo "INSTALLING:)"
    mkdir /root/ssh_vpn_$VPN_NAME
    cp temp_files/rc.local /etc/rc.local
    cp temp_files/ssh_vpn_$VPN_NAME /etc/init.d/ssh_vpn_$VPN_NAME
    cp temp_files/crontab /var/spool/cron/crontabs/root
    cp temp_files/create_if.sh /root/ssh_vpn_$VPN_NAME/create_if.sh
    cp temp_files/check-if-vpn-ok.sh /root/ssh_vpn_$VPN_NAME/check-if-vpn-ok.sh
    cp key /root/ssh_vpn_$VPN_NAME/key
fi

