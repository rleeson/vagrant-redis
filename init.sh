#!/bin/bash

# Update the OS, packages, and install required build dependencies
sudo apt-get update
#sudo apt-get upgrade -y
sudo apt-get -y install build-essential tcl

# Download and extract the latest Redis version in a temp location
cd /tmp
curl -O http://download.redis.io/redis-stable.tar.gz
tar xvzf redis-stable.tar.gz

# Build, test, and install the downloaded Redis version
cd redis-stable
make
make test
sudo make install

# Setup configuration and working data directories
sudo mkdir /etc/redis
sudo mkdir -p /var/redis/6379

# Copy configuration files for redis and the service into place
sudo cp /tmp/redis.conf /etc/redis/6379.conf
sudo cp /tmp/redis.service /etc/systemd/system/redis.service

# Add a user to run Redis and assign working directory rights (see redis.conf)
sudo useradd --system --group --no-create-home redis
sudo chown -R redis:redis /var/redis
sudo chmod 770 /var/redis/6379

# Start the Redis service and check its run status
sudo systemctl start redis
sudo systemctl status redis