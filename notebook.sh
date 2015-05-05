#!/bin/bash

if [ $# -lt 1 ]
then
        echo "Usage : notebook.sh <command>"
        echo "Available commands: [start, logs, stop]"
        exit
fi

# Load the config file
source ./config.cfg

case "$1" in

start) echo "running the notebook"
    docker run -d -p $PORT_NOTEBOOK:8888 \
        -v /Users/pire:/work/pire \
        --name $NOTEBOOK_NAME \
        piredtu/topfarm_notebook
    sleep 0.5
    open http://docker:$PORT_NOTEBOOK
    ;;

log) echo "showing logs"
    docker logs -f $NOTEBOOK_NAME
    ;;

stop) echo "stopping the notebook"
    docker stop $NOTEBOOK_NAME
    docker rm $NOTEBOOK_NAME
    ;;

esac
