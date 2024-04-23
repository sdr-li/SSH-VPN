#!/bin/sh
mkdir -p /dev/net
mknod /dev/net/tun c 10 200
chmod 666 /dev/net/tun
#rc-service sshd start
#/etc/init.d/networking restart
echo 'root':$ROOTPASS | chpasswd
#cp /appdata/ssh-tunnel /etc/init.d/ssh-tunnel
#rc-service ssh-tunnel start
/appdata/ssh-tunnel.sh
