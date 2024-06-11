## SSH-VPN

### Introduction

SSH-VPN is a project of stand-alone SSH server with proper configuration so to allow tunneling in L3, using only SSH ports.
It utilizes non-so-well-known functionality provided by OpenSSH, that allows remote users to establish not only port forwarding (-L) but also whole interface (in L3 or even in L2) tunneling(-w). This tool is docker image - designed to be the most lightweight - so uses Alpine Linux.

For the project, there are also attached client scripts, as well as docker image example

### How does it work?

In the SSH-VPN container, one OpenSSH server is run. When container starts, all users defined in "users" file, are created. Besides them, also corresponding interface for each user is created, as well as provided IP addresses are set to them. Static IP routes setup ability coming soon.

### How to run server?

- build project, using attached *server/scripts/build.sh*

Then do proper configuration:
- run *server/scripts/generate_ssh_key_user.sh* inside the *server/example/scripts* to create public/private SSH key pair for each user
- run *server/scripts/generate_ssh_key_host.sh* inside the *server/example/scripts* to create host keys for SSH server
- run **docker-compose up** inside the *server/example* directory

in file *users*, You can define username, password, interface name(without prefix tun), and IP address(of gateway) per each interface.
Following example defines 4 users, with their passwords. For each user, very small subnet was created. Defined IP is associated with interface on server side - with gateway - so in this scenario client should use the next IP address(and as for /30, the last usable one).
Password login is disabled by default for increased security, It can be enabled with ``` PasswordAuthentication yes ``` defined inside **sshd_config** file.

```
example_user_0:example_pass_0:101:10.242.10.1/30
example_user_1:example_pass_0:102:10.242.10.5/30
example_user_2:example_pass_0:103:10.242.10.9/30
example_user_3:example_pass_0:104:10.242.10.13/30
```
If client would like to connect with the other IP's than the gateway, according static IP routing should be set on client side as well as on server side.


##### With attached docker example


### How to connect?

there are numerous ways to establish VPN connection. In this project, there are 3 different examples:
- scripts(quick and temporary connection from Your desktop)
- systemd configuration (to permanently connect VM to VPN gateway)
- docker - alpine based image (to permanently connect docker-network to VPN gateway)


#### From Your desktop linux OS
Assuming that we want to use **example_user_0** configuration - run following on the client:
- create tun interface associated with Your username ``` sudo ip tuntap add mode tun user yourusernameonclientmachine name tun24 ```
- assign proper IP address to the interface ``` sudo ip addr add 10.242.10.2/30 dev tun24 ```
- bring up newly created interface ``` sudo ip link set tun24 up ```
- create tunnel connection with the server - connect with ssh server - ``` ssh -i server/example/keys/example_user_0 example_user_0@ipofsshvpnserver -w24:101 ``` then provide password. Be aware, that for VPN users(vpn-users group), executing commands over SSH is not available, and was intentionally blocked with ``` ForceCommand /bin/false ``` inside **sshd_config** file

Or instead of doing that, You can just run a scripts from *client/connection-script* in correct order...

#### Using docker example

##### Use-case
You could use this client, if You had docker-compose project with many different containers, which share the same docker-created-network, and You had a need to get an access to this network. In that scenario, the ssh-vpn-client plays a role of gateway, that allows the other parties, that also have an access to the VPN(other clients), to access inter-container-network.

##### Configuration
You basically need to provide working private key to file *client/docker/example/container-data/key* (as an example, example_user_0 key was provided).
Besides that, some environmentals should be set inside docker-compose file
```
environment:
    - ROOTPASS=shithappens
    - SERVER_IP=10.253.9.2
    - LOCAL_TUN_IP=10.242.10.2/30
    - LOCAL_TUN_IF=101
    - REMOTE_TUN_IF=101
    - USERNAME=example_user_0
    - KEY_PATH=/appdata/key
```

##### Run it...
... using docker-compose up

#### Using systemd

You can also put *client/systemd-script* files onto VM(when logged as a root), configure variables from *install.sh*, and execute this file - while being on VM. This will create a ssh connection that will start on boot, and in case of ssh connection(tunnel) breaks, gets restored(```  Restart=always ``` and ``` RestartSec=15s ``` in systemd file).

##### Configuration
Edit *install.sh* environmental variables.

##### Install
Run *./install.sh* inside it's directory.

### TODO

#### Server
- firewall (Awall)
- DNS server
- ~~support for SSH keys(password-less login)~~ DONE!
- better way to add static ip routing
- wrapping everything in Webproc
- updating setup without breaking SSH sessions

#### Client
- no idea yet:)


### Disclaimer

Have fun, and do not use this solution where it is expicitly forbidden!
Remove SSH keys. Nope, they are not used anywhere:).
