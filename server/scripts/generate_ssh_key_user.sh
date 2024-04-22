#!/bin/sh

echo "username: "
read USER
ssh-keygen -t rsa -P "" -C $USER -f $(dirname "$0")/../example/keys/$USER -q

cp $(dirname "$0")/../example/keys/$USER.pub $(dirname "$0")/../example/container-data/pub-keys/$USER.pub
