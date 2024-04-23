#!/bin/sh
set -x
x = 1
# NEED TO DEFINE THOSE IN DOCKER-COMPOSE
#SERVER_IP="10.253.9.2"
#LOCAL_TUN_IP="10.242.10.2/30"
#LOCAL_TUN_IF="101"
#REMOTE_TUN_IF="101"
#USERNAME="example_user_0"
#KEY_PATH="/appdata/key"
ip tuntap add mode tun user root name tun$LOCAL_TUN_IF
ip addr add $LOCAL_TUN_IP dev tun$LOCAL_TUN_IF
ip link set tun$LOCAL_TUN_IF up

ls -l /appdata/

while true
do
  ssh -i $KEY_PATH $USERNAME@$SERVER_IP -w $LOCAL_TUN_IF:$REMOTE_TUN_IF
  echo "Connection failed or closed! trying again in 10 seconds"
  sleep 10
done
