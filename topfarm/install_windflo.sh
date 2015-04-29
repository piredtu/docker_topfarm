#!/bin/bash
. /install/openmdao-0.10.3.2/bin/activate
cd /install
git clone https://github.com/piredtu/WindFLO.git
cd WindFLO/Python
make install
