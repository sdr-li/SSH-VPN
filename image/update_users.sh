#!/bin/sh


echo 'root':$ROOTPASS | chpasswd

input="./users"
while IFS= read -r line
do
    input="${line}"
    echo $input
    USER=$(echo "$input" | cut -d ':' -f 1)
    PASS=$(echo "$input" | cut -d ':' -f 2)
    TUN_ID=$(echo "$input" | cut -d ':' -f 3)
    IP=$(echo "$input" | cut -d ':' -f 4)

    adduser $USER -G vpn-users -D
    echo $USER:$PASS | chpasswd

    ip tuntap add mode tun user $USER name "tun"$TUN_ID
    ip addr add $IP dev "tun"$TUN_ID
    ip link set "tun"$TUN_ID up

done < "$input"
