echo nameserver 192.168.122.1 > /etc/resolv.conf
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
INTERFACES="eth1 eth2 eth0"

# Additional options that are passed to the DHCP relay daemon?
OPTIONS=""' > /etc/default/isc-dhcp-relay
/etc/init.d/isc-dhcp-relay restart
echo 1 > /proc/sys/net/ipv4/ip_forward
iptables -F
iptables -t nat -F
iptables -X
iptables -A PREROUTING -t nat -d 10.47.0.2 -p tcp --dport 80 -m statistic --mode nth --every 2 --packet 0 -j DNAT --to-destination 10.47.0.66:80
iptables -t nat -A POSTROUTING -p tcp -d 10.47.0.66 --dport 80 -j SNAT --to-source 10.47.0.65
iptables -A PREROUTING -t nat -d 10.47.0.2 -p tcp --dport 80 -j DNAT --to-destination 10.47.0.67:80
iptables -t nat -A POSTROUTING -p tcp -d 10.47.0.67 --dport 80 -j SNAT --to-source 10.47.0.65
