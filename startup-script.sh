#!/bin/bash
#
# This script installs ruby, mongodb and dependencies for running reddit application.
#
# prepare keys and repos
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" > /etc/apt/sources.list.d/mongodb-org-3.2.list
apt update

# install software
apt install -y ruby-full ruby-bundler build-essential mongodb-org
systemctl start mongod
systemctl enable mongod

# install app with dependencies
cd /home/appuser
sudo -u appuser git clone -b monolith https://github.com/express42/reddit.git
cd reddit
sudo -u appuser bundle install

# run app
sudo -u appuser puma -d
