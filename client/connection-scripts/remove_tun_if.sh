#!/bin/sh
echo "Type number for TUN interface planned for deletion: "
read tun_num
sudo ip link del tun$tun_num
