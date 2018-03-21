#!/bin/bash
#
# This script deploys reddit application.
# ruby, bundle and mongodb have to be installed before
#
set -e

adduser --system --no-create-home --group pumaserver
cd /var/opt
git clone -b monolith https://github.com/express42/reddit.git
cd reddit
bundle install
chown -R pumaserver:pumaserver /var/opt/reddit
cp /home/appuser/files/puma.service /etc/systemd/system/puma.service
systemctl enable puma
#systemctl start  puma
