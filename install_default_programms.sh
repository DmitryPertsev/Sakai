#!/bin/bash

apt-get update -y
apt-get install docker.io git docker-compose -y
groupadd docker
gpasswd -a $USER docker


read -r -p "Log out and log back in so that your group membership is re-evaluated.\n
            If testing on a virtual machine, it may be necessary to restart the virtual machine for changes to take effect.
	    Log out now [y/n]... " response

if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]
then
	pkill -u $USER
else
	echo "Do it late"
fi
