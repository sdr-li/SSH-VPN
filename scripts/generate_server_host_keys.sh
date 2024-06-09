#!/bin/sh
ssh-keygen -q -C "" -N "" -t rsa -b 4096 -f server-host-ssh/ssh_host_rsa_key
ssh-keygen -q -C "" -N "" -t ecdsa -f server-host-ssh/ssh_host_ecdsa_key
ssh-keygen -q -C "" -N "" -t ed25519 -f server-host-ssh/ssh_host_ed25519_key

cat server-host-ssh/ssh_host_rsa_key.pub
cat server-host-ssh/ssh_host_ecdsa_key.pub
cat server-host-ssh/ssh_host_ed25519_key.pub

cp server-host-ssh/ssh_host_rsa_key* ../server/example/container-data/host-keys/
cp server-host-ssh/ssh_host_ecdsa_key* ../server/example/container-data/host-keys/
cp server-host-ssh/ssh_host_ed25519_key* ../server/example/container-data/host-keys/
