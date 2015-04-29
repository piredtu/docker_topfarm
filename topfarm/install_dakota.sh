#!/bin/bash

apt-get install -y \
	cmake \
	libboost1.54-all-dev \
	libopenmpi-dev \
	openmpi-bin \ 
	openmpi-doc

ldconfig

cd /install/
curl https://dakota.sandia.gov/sites/default/files/distributions/public/dakota-6.1-public.src_.tar.gz > dakota.tar.gz
tar xvf dakota.tar.gz
cd dakota-6.1.0.src/
export DAK_SRC=$(pwd)
export DAK_BUILD=/install/dakota-build
mkdir $DAK_BUILD

cp BuildDakotaTemplace.cmake $DAK_SRC/cmake/BuildDakotaCustom.cmake
cd $DAK_BUILD
cmake -C $DAK_SRC/cmake/BuildDakotaCustom.cmake $DAK_SRC
make
make install
