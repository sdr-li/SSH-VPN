ip tuntap add mode tun user root name tun101
ip addr add 10.242.10.2/30 dev tun101
ip link set tun101 up
