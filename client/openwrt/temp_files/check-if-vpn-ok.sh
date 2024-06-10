#!/bin/sh
ping -c1 10.242.10.1 /dev/null
if [ $? -eq 0 ]
  then
    echo ok
    exit 0
  else
  echo "error"
  /etc/init.d/ssh_vpn_tun101 stop
  sleep 10
  /etc/init.d/ssh_vpn_tun101 start
fi
