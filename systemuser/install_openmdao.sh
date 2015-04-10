#!/bin/bash
for OMDAOVER in 0.10.3.2 0.12.0; do
curl http://openmdao.org/releases/$OMDAOVER/go-openmdao-$OMDAOVER.py | python2
done
