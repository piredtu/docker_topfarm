#!/bin/bash
curl http://www.coin-or.org/download/source/Ipopt/Ipopt-3.12.1.tgz > Ipopt-3.12.1.tgz
tar xvf Ipopt-3.12.1.tgz
cd Ipopt-3.12.1
cd ThirdParty/Metis
./get.Metis
cd ..
cd Mumps
./get.Mumps
cd ../..
./configure --prefix=/usr/local
make
make install
echo "/usr/local/lib" >> /etc/ld.so.conf
ldconfig
