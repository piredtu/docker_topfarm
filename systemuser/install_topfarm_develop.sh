#!/bin/bash

git clone http://github.com/DTUWindEnergy/TOPFARM.git $HOME/topfarm
cd $HOME/topfarm
. /install/openmdao-0.10.3.2/bin/activate
python setup.py develop
