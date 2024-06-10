!#/bin/sh
ip tuntap add mode tun user root name <VPN_NAME>
ip addr add <VPN_LOCAL_IP>/<VPN_SUBNET> dev <VPN_NAME>
ip link set <VPN_NAME> up
