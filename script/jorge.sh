echo nameserver 10.47.0.74 > /etc/resolv.conf
apt-get install apache2 -y
service apache2 start
echo 'ini Jorge' > /var/www/html/index.html
