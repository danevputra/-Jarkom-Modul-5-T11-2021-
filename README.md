# Jarkom-Modul-5-T11-2021

Nama Anggota | NRP
------------------- | --------------		
Justin Alfonsius Sitanggang | 05311840000043
Daniel Evan | 05311940000016
Calvin Manuel | 05311940000049

## Soal A
Tugas pertama kalian yaitu membuat topologi jaringan sesuai dengan rancangan yang diberikan Luffy

### Jawaban
Berikut adalah topologi yang kami buat berdasarkan topologi yang ada pada soal
<br><img src="ss/1.JPG">

## Soal B
Karena kalian telah belajar subnetting dan routing, Luffy ingin meminta kalian untuk membuat topologi tersebut menggunakan teknik CIDR atau VLSM. setelah melakukan subnetting

### Jawaban
Pada soal shift kali ini kami menggunakan teknik VLSM untuk melakukan subnetting dan routing, berikut adalah pembagian subnet pada topologi
<br><img src="ss/vlsm.jpg"><br>

Total terdapat 8 buah subnet dengan 1314 total host, selanjutnya kami membuat pembagiannya menggunakan tree
<br><img src="ss/tree vlsm.jpg"><br>

Setelah membuat tree, selanjutya kami mengatur IP pada tiap node-nya sebagai berikut

- Foosha
```
auto eth0
iface eth0 inet static
	address 192.168.122.84
	netmask 255.255.255.0
        gateway 192.168.122.1

auto eth1
iface eth1 inet static
	address 10.47.0.1
	netmask 255.255.255.252

auto eth2
iface eth2 inet static
	address 10.47.0.5
	netmask 255.255.255.252
```
- Water7
```
auto eth0
iface eth0 inet static
	address 10.47.0.6
	netmask 255.255.255.252
	gateway 10.47.0.5

auto eth1
iface eth1 inet static
	address 10.47.4.1
	netmask 255.255.252.0
	gateway 10.47.0.5

auto eth2
iface eth2 inet static
	address 10.47.0.129
	netmask 255.255.255.128
	gateway 10.47.0.5

auto eth3
iface eth3 inet static
	address 10.47.0.73
	netmask 255.255.255.248
	gateway 10.47.0.5
```
- Guanhao
```
auto eth0
iface eth0 inet static
	address 10.47.0.2
	netmask 255.255.255.252
	gateway 10.47.0.1

auto eth1
iface eth1 inet static
	address 10.47.2.1
	netmask 255.255.254.0
	gateway 10.47.0.1

auto eth2
iface eth2 inet static
	address 10.47.1.1
	netmask 255.255.255.0
	gateway 10.47.0.1

auto eth3
iface eth3 inet static
	address 10.47.0.65
	netmask 255.255.255.248
	gateway 10.47.0.1
```
- Doriki
```
auto eth0
iface eth0 inet static
	address 10.47.0.74
	netmask 255.255.255.248
	gateway 10.47.0.73
```
- Jipangu
```
auto eth0
iface eth0 inet static
	address 10.47.0.75
	netmask 255.255.255.248
	gateway 10.47.0.73
```
- Jorge
```
auto eth0
iface eth0 inet static
	address 10.47.0.66
	netmask 255.255.255.248
	gateway 10.47.0.65
```
- Maingate
```
auto eth0
iface eth0 inet static
	address 10.47.0.67
	netmask 255.255.255.248
	gateway 10.47.0.65
```
- Blueno, Cipher, Elena, Fukurou (dhcp)
```
auto eth0
iface eth0 inet dhcp
```

## Soal C
Kalian juga diharuskan melakukan Routing agar setiap perangkat pada jaringan tersebut dapat terhubung.

### Jawaban
Berikut adalah routing yang kami lakukan (semua routing terletak pada Foosha)
```
route add -net 10.47.2.0 netmask 255.255.254.0 gw 10.47.0.2
route add -net 10.47.1.0 netmask 255.255.255.0 gw 10.47.0.2
route add -net 10.47.0.64 netmask 255.255.255.248 gw 10.47.0.2
route add -net 10.47.0.128 netmask 255.255.255.128 gw 10.47.0.6
route add -net 10.47.4.0 netmask 255.255.252.0 gw 10.47.0.6
route add -net 10.47.0.72 netmask 255.255.255.248 gw 10.47.0.6
```

## Soal D
Tugas berikutnya adalah memberikan ip pada subnet Blueno, Cipher, Fukurou, dan Elena secara dinamis menggunakan bantuan DHCP server. Kemudian kalian ingat bahwa kalian harus setting DHCP Relay pada router yang menghubungkannya.

### Jawaban

## Soal 1
Agar topologi yang kalian buat dapat mengakses keluar, kalian diminta untuk mengkonfigurasi Foosha menggunakan iptables, tetapi Luffy tidak ingin menggunakan MASQUERADE.

### Jawaban

## Soal 2
Kalian diminta untuk mendrop semua akses HTTP dari luar Topologi kalian pada server yang merupakan DHCP Server dan DNS Server demi menjaga keamanan.

### Jawaban

## Soal 3
Karena kelompok kalian maksimal terdiri dari 3 orang. Luffy meminta kalian untuk membatasi DHCP dan DNS Server hanya boleh menerima maksimal 3 koneksi ICMP secara bersamaan menggunakan iptables, selebihnya didrop.

### Jawaban

## Soal 4
Akses dari subnet Blueno dan Cipher hanya diperbolehkan pada pukul 07.00 - 15.00 pada hari Senin sampai Kamis.

### Jawaban

## Soal 5
Akses dari subnet Elena dan Fukuro hanya diperbolehkan pada pukul 15.01 hingga pukul 06.59 setiap harinya. Selain itu di reject


### Jawaban

## Soal 6
Karena kita memiliki 2 Web Server, Luffy ingin Guanhao disetting sehingga setiap request dari client yang mengakses DNS Server akan didistribusikan secara bergantian pada Jorge dan Maingate

### Jawaban
