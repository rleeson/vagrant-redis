#!/bin/bash

# Update the OS, packages, and install required build dependencies
echo "Updating package list"
sudo apt-get update > /dev/null

echo "Upgrading packages"
sudo apt-get upgrade -y > /dev/null

echo "Installing build dependencies"
sudo apt-get -y install build-essential tcl > /dev/null

# Download and extract the latest Redis version in a temp location
cd /tmp
echo "Downloading the latest redis stable version and extracting"
curl -O http://download.redis.io/redis-stable.tar.gz
tar -xzf redis-stable.tar.gz

# Build, test, and install the downloaded Redis version
cd redis-stable
echo "Making the installer"
make > /dev/null

echo "Testing the install"
make test > /dev/null

echo "Installing Redis"
sudo make install > /dev/null

# Setup configuration and working data directories
sudo mkdir /etc/redis
sudo mkdir -p /var/redis/6379

# Copy configuration files for redis and the service into place
echo "Distributing Redis configuration"
sudo cp /tmp/redis.conf /etc/redis/6379.conf
sudo cp /tmp/redis.service /etc/systemd/system/redis.service

# Add a user to run Redis and assign working directory rights (see redis.conf)
echo "Adding a user for Redis and assigning proper permissions"
sudo adduser --system --group --no-create-home redis
sudo chown -R redis:redis /var/redis
sudo chmod 770 /var/redis/6379

# Start the Redis service and check its run status
echo "Enabling Redis auto-start"
sudo systemctl enable redis
sudo systemctl start redis
sudo systemctl status redis