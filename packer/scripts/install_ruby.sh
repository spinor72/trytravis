#!/bin/bash
#
# This script installs ruby
#
set -e
apt update
apt install -y ruby-full ruby-bundler build-essential
