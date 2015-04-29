#!/bin/bash
. /install/openmdao-0.10.3.2/bin/activate
pip install --upgrade pip

## Install FUSED-Wake
export INSTALL_DIR=/install
cd $INSTALL_DIR
git clone http://github.com/DTUWindEnergy/FUSED-Wake.git
cd $INSTALL_DIR/FUSED-Wake/gclarsen
python setup.py install
cd $INSTALL_DIR/FUSED-Wake/py4we
python setup.py install

pip install git+http://github.com/xuy/pyipopt.git#egg=pyipopt
pip install git+http://github.com/OpenMDAO-Plugins/ipoptdriver.git#ipoptdriver
pip install svn+http://svn.pyopt.org/tags/release-1.1.0#egg=pyopt
pip install git+http://github.com/OpenMDAO-Plugins/pyopt_driver.git@0.19#egg=pyopt_driver

# Should be added in topfarm requirements.txt
pip install --upgrade matplotlib
pip install ipython
pip install -e git+http://github.com/DTUWindEnergy/TOPFARM.git#egg=topfarm
