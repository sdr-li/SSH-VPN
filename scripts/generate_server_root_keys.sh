#!/bin/sh
ssh-keygen -t rsa -P "" -C "" -f server-root-ssh/key -q
cat server-root-ssh/key.pub
cp server-root-ssh/key.pub ../client/docker/example/container-data/master-ssh-key.pub
cp server-root-ssh/key.pub ../server/example/container-data/pub-keys/root.pub
