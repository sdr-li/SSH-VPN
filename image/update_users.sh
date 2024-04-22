#!/bin/sh


echo 'root':$ROOTPASS | chpasswd
mkdir /root/.ssh
if test -f /appdata/pub-keys/root.pub; then
    cp /appdata/pub-keys/root.pub /root/.ssh/authorized_keys
fi
cp /appdata/host-keys/* /etc/ssh/


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
    mkdir /home/$USER/.ssh
    if test -f /appdata/pub-keys/$USER.pub; then
        cp /appdata/pub-keys/$USER.pub /home/$USER/.ssh/authorized_keys
    fi

    ip tuntap add mode tun user $USER name "tun"$TUN_ID
    ip addr add $IP dev "tun"$TUN_ID
    ip link set "tun"$TUN_ID up

done < "$input"
