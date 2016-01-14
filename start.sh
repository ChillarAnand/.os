#! /bin/sh

cd
mkdir -p projects/ubuntu
cd projects/ubuntu

sudo apt-get install --yes git
git config --global user.name 'chillaranand'
git clone https://github.com/ChillarAnand/os.git
cd os
git pull origin master


# salt

if ! apt-get -qq install salt-minion; then
    ./salt/start/master.sh
    ./salt/start/minion.sh
fi

sudo cp salt/start/minion /etc/salt/
sudo cp salt/start/master /etc/salt/

sudo service salt-master restart
sudo service salt-minion restart
