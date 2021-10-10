#!/bin/bash

while true; do
    read -p "Do you wish to remove the docker? " yn
    case $yn in
        [Yy]* ) break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

docker container stop ctf
docker container rm ctf
