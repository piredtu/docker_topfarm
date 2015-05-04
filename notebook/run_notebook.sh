#!/bin/bash
cd $HOMEDIR

git config --global user.email "$GIT_NAME"
git config --global user.name "$GIT_EMAIL"

ipython notebook --ip=0.0.0.0 --port=$PORT
