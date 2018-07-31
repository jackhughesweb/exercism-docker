#!/bin/bash
set -e

cd /opt/rails
rm -f tmp/pids/server.pid

bin/rails server -b 0.0.0.0
