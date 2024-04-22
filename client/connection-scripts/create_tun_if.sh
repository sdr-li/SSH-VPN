#!/bin/sh
echo "Type number for new TUN interface: "
read tun_num
echo "Type your IP address(in CIDR form): "
read ipaddress

sudo ip tuntap add mode tun user $USER name tun$tun_num
sudo ip addr add $ipaddress dev tun$tun_num
sudo ip link set tun$tun_num up
