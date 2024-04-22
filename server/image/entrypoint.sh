#!/bin/sh
mkdir -p /dev/net
mknod /dev/net/tun c 10 200
chmod 666 /dev/net/tun
#rc-service sshd start
/appdata/update_users.sh
/etc/init.d/networking restart
/usr/sbin/sshd -D -e
