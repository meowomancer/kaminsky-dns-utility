#!/bin/sh
apt-get install libdnet-dev
apt-get install libpcap-dev
cd /usr
mkdir /usr/nembuild
cd /usr/nembuild
wget http://ips-builder.googlecode.com/files/libnet-1.0.2a.tar.gz
tar -xf libnet-1.0.2a.tar.gz
cd Libnet-1.0.2a
./configure
make && make install
cd /usr/nembuild
wget http://heanet.dl.sourceforge.net/project/nemesis/nemesis/1.4/nemesis-1.4.tar.gz
tar -xf nemesis-1.4.tar.gz
cd nemesis-1.4
./configure --with-libnet-includes=/usr/nembuild/Libnet-1.0.2a/include --with-libnet-libraries=/usr/nembuild/Libnet-1.0.2a/lib
make && make install