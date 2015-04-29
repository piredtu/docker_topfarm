#!/bin/bash
. /install/openmdao-0.10.3.2/bin/activate
pip install --upgrade pip


## Install FUSED-Wind
pip install -e git+http://github.com/FUSED-Wind/fusedwind.git#egg=fusedwind
