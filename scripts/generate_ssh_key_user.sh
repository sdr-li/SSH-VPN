#!/bin/sh

echo "username: "
read USER
ssh-keygen -t rsa -P "" -C $USER -f server-users-ssh/$USER -q

cp server-users-ssh/$USER.pub ../server/example/container-data/pub-keys/
