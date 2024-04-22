#!/bin/sh
ssh-keygen -q -C "" -N "" -t rsa -b 4096 -f $(dirname "$0")/../example/container-data/host-keys/ssh_host_rsa_key
ssh-keygen -q -C "" -N "" -t ecdsa -f $(dirname "$0")/../example/container-data/host-keys/ssh_host_ecdsa_key
ssh-keygen -q -C "" -N "" -t ed25519 -f $(dirname "$0")/../example/container-data/host-keys/ssh_host_ed25519_key
