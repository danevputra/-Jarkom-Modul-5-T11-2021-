echo nameserver 192.168.122.1 > /etc/resolv.conf
apt-get install bind9 -y
sed -i '21iforwarders {\n         192.168.122.1;\n};' /etc/bind/named.conf.options
sed -i "s_dnssec-validation auto;_//dnssec-validation auto;_g" /etc/bind/named.conf.options
sed -i '25i     allow-query{any;};' /etc/bind/named.conf.options
iptables -A INPUT -p icmp -m connlimit --connlimit-above 3 --connlimit-mask 0 -j DROP
iptables -A INPUT -s 10.47.0.128/25 -m time --timestart 07:00 --timestop 15:00 --weekdays Mon,Tue,Wed,Thu -j ACCEPT
iptables -A INPUT -s 10.47.0.128/25 -j REJECT
iptables -A INPUT -s 10.47.4.0/22 -m time --timestart 07:00 --timestop 15:00 --weekdays Mon,Tue,Wed,Thu -j ACCEPT
iptables -A INPUT -s 10.47.4.0/22 -j REJECT
iptables -A INPUT -s 10.47.2.0/23 -m time --timestart 06:59 --timestop 15:01 -j ACCEPT
iptables -A INPUT -s 10.47.2.0/23 -j REJECT
iptables -A INPUT -s 10.47.1.0/24 -m time --timestart 06:59 --timestop 15:01 -j ACCEPT
iptables -A INPUT -s 10.47.1.0/24 -j REJECT
echo 'zone "jarkom2021.com" {
        type master;
        file "/etc/bind/jarkom/jarkom2021.com";
};' >> /etc/bind/named.conf.local
mkdir /etc/bind/jarkom
cp /etc/bind/db.local /etc/bind/jarkom/jarkom2021.com
echo ';
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     jarkom2021.com. root.jarkom2021.com. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      jarkom2021.com.
@       IN      A       10.47.0.2
@       IN      AAAA    ::1' > /etc/bind/jarkom/jarkom2021.com
service bind9 restart
