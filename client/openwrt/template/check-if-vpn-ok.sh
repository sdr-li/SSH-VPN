
if ping -c 1 <VPN_REMOTE_IP> &> /dev/null
then
  echo ok
  exit 0
else
  echo "error"
  /etc/init.d/ssh_vpn_<VPN_NAME> stop
  sleep 10
  /etc/init.d/ssh_vpn_<VPN_NAME> start
fi
