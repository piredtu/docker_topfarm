#!/bin/bash

if [ $# -lt 1 ]
then
        echo "Usage : hub.sh <command>"
        echo "Available commands: [start, logs, stop]"
        exit
fi

# Load the config file
source ./config.cfg

case "$1" in

start) echo "running the hub"
    docker run -d -p 8000:8000 --net=host \
        -v /var/run/docker.sock:/docker.sock \
        -v /var/run/restuser.sock:/restuser.sock \
        -e 'USER_IMAGE=$USER_IMAGE' \
        --env-file $GITHUB_APP\
        --name $HUB_NAME \
        $HUB_IMAGE
    ;;

log) echo "showing logs"
    docker logs -f $HUB_NAME
    ;;

stop) echo "stopping the hub"
    docker stop $HUB_NAME
    docker rm $HUB_NAME
    ;;

restuser)
    nohup python restuser/restuser.py --socket=/var/run/restuser.sock > rest.log &

esac
