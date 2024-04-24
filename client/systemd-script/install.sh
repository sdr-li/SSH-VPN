#!/bin/sh
set -x
# NEED TO DEFINE THOSE!!
SERVER_IP="10.253.9.2"
LOCAL_TUN_IP="10.242.10.2/30"
LOCAL_TUN_IF="101"
REMOTE_TUN_IF="101"
USERNAME="example_user_0"
KEY_PATH="/root/ssh-tunnel/key"

rm command.conf
echo "-i $KEY_PATH $USERNAME@$SERVER_IP -w $LOCAL_TUN_IF:$REMOTE_TUN_IF" >> command.conf

rm pre-up.sh
echo "ip tuntap add mode tun user root name tun$LOCAL_TUN_IF" >> pre-up.sh
echo "ip addr add $LOCAL_TUN_IP dev tun$LOCAL_TUN_IF" >> pre-up.sh
echo "ip link set tun$LOCAL_TUN_IF up" >> pre-up.sh

cp ssh_vpn_systemd_template /etc/systemd/system/ssh_vpn_0.service
cp command.conf /root/ssh-tunnel/command.conf
cp pre-up.sh /root/ssh-tunnel/pre-up.sh
cp key /root/ssh-tunnel/key


systemctl enable ssh_vpn_0.service
systemctl start ssh_vpn_0.service
