iptables -t nat -A POSTROUTING -s 10.47.0.0/16 -o eth0 -j SNAT --to-source 192.168.122.84
echo nameserver 192.168.122.1 > /etc/resolv.conf
route add -net 10.47.2.0 netmask 255.255.254.0 gw 10.47.0.2
route add -net 10.47.1.0 netmask 255.255.255.0 gw 10.47.0.2
route add -net 10.47.0.64 netmask 255.255.255.248 gw 10.47.0.2
route add -net 10.47.0.128 netmask 255.255.255.128 gw 10.47.0.6
route add -net 10.47.4.0 netmask 255.255.252.0 gw 10.47.0.6
route add -net 10.47.0.72 netmask 255.255.255.248 gw 10.47.0.6
apt-get install isc-dhcp-relay -y
echo ' # Defaults for isc-dhcp-relay initscript
# sourced by /etc/init.d/isc-dhcp-relay
# installed at /etc/default/isc-dhcp-relay by the maintainer scripts

#
# This is a POSIX shell fragment
#

# What servers should the DHCP relay forward requests to?
SERVERS="10.47.0.75"

# On what interfaces should the DHCP relay (dhrelay) serve DHCP requests?
INTERFACES="eth1 eth2"

# Additional options that are passed to the DHCP relay daemon?
OPTIONS=""' > /etc/default/isc-dhcp-relay
/etc/init.d/isc-dhcp-relay restart
iptables -A FORWARD -d 10.47.0.72/29 -i eth0 -p tcp -m tcp --dport 80 -j DROP
