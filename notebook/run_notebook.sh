#!/bin/bash

cd $HOMEDIR/topfarm
if [ -f /install/id_rsa ]; then
    # If the id_rsa is passed then it's added to the ssh-agent
    ssh-agent
    ssh-add /install/id_rsa
    # TODO: FIX THIS!
    # And the url of the repository is changed to use ssh
    git remote set-url origin git@github.com:DTUWindEnergy/TOPFARM.git
fi

git config --global user.email "$GIT_NAME"
git config --global user.name "$GIT_EMAIL"

ipython notebook --ip=0.0.0.0 --port=$PORT
