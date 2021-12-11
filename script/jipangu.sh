echo nameserver 192.168.122.1 > /etc/resolv.conf
apt-get install isc-dhcp-server -y
dhcpd --version
sed -i '$ d' /etc/default/isc-dhcp-server
echo -e 'INTERFACES="eth0"' >> /etc/default/isc-dhcp-server
echo 'subnet 10.47.0.72 netmask 255.255.255.248{
}

subnet 10.47.0.128 netmask 255.255.255.128 {
    range 10.47.0.130 10.47.0.254;
    option routers 10.47.0.129;
    option broadcast-address 10.47.0.255;
    option domain-name-servers 10.47.0.74;
    default-lease-time 360;
    max-lease-time 7200;
}

subnet 10.47.4.0 netmask 255.255.252.0 {
    range 10.47.4.2 10.47.7.254;
    option routers 10.47.4.1;
    option broadcast-address 10.47.7.255;
    option domain-name-servers 10.47.0.74;
    default-lease-time 360;
    max-lease-time 7200;
}

subnet 10.47.2.0 netmask 255.255.254.0 {
    range 10.47.2.2 10.47.3.254;
    option routers 10.47.2.1;
    option broadcast-address 10.47.3.255;
    option domain-name-servers 10.47.0.74;
    default-lease-time 360;
    max-lease-time 7200;
}

subnet 10.47.1.0 netmask 255.255.255.0 {
    range 10.47.1.2 10.47.1.254;
    option routers 10.47.1.1;
    option broadcast-address 10.47.1.255;
    option domain-name-servers 10.47.0.74;
    default-lease-time 360;
    max-lease-time 7200;
}' >> /etc/dhcp/dhcpd.conf
service isc-dhcp-server restart
service isc-dhcp-server status
iptables -A INPUT -p icmp -m connlimit --connlimit-above 3 --connlimit-mask 0 -j DROP
