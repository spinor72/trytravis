#!/bin/bash
#
# This script deploys reddit application.
# ruby, bundle and mongodb have to be installed before
#
git clone -b monolith https://github.com/express42/reddit.git
cd reddit
bundle install
puma -d
