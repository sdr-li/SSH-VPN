#!/bin/sh

SERVER_IP="10.253.9.2"
LOCAL_TUN_IF="101"
REMOTE_TUN_IF="101"
USERNAME="example_user_0"
KEY_PATH="key"

while :
do
  ssh -i $KEY_PATH $USERNAME@$SERVER_IP -w $LOCAL_TUN_IF:$REMOTE_TUN_IF
  echo "Connection closed! trying again in 10 seconds"
  sleep 10
done
