#!/bin/bash
set -e

cd /opt/rails
rm -f tmp/pids/server.pid

# Install ruby libraries
bundle install

# Install JavaScript libraries
bin/rails yarn:install

bin/rails server -b 0.0.0.0
