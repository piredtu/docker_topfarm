#!/bin/bash
VENVDIR=/install
if [ ! -d $HOME/.ipython/kernels ]; then
  mkdir $HOME/.ipython/kernels
fi
for OMDAOVER in 0.10.3.2 0.12.0; do
if [ ! -d $HOME/.ipython/kernels/openmdao-$OMDAOVER ]; then
  mkdir $HOME/.ipython/kernels/openmdao-$OMDAOVER
fi
cat > $HOME/.ipython/kernels/openmdao-$OMDAOVER/kernel.json <<EOF
{
 "display_name": "Openmdao-$OMDAOVER", 
 "argv": [
  "$VENVDIR/openmdao-$OMDAOVER/bin/python", 
  "-m", 
  "IPython.kernel", 
  "-f", 
  "{connection_file}"
 ]
}
EOF
done
