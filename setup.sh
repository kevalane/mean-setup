#! bin/bash

echo "
Initializing..."
echo "
-----------------------
Author: Kevin Ramsusson
-----------------------"

echo "
-----------------------
    NPM & NodeJS:
-----------------------"

# Add latest nodejs using nodesource current version
curl -fsSL https://deb.nodesource.com/setup_current.x | sudo -E bash -

# Install nodejs, npm
sudo apt-get install -y nodejs

echo "Done with NPM & NodeJS, let's continue..."
echo "-----------------"


echo "
-----------------------
    MongoDB
-----------------------"
# https://www.digitalocean.com/community/tutorials/how-to-install-mongodb-on-ubuntu-20-04

# Import mongodb key and add to trusted keys
curl -fsSL https://www.mongodb.org/static/pgp/server-4.4.asc | sudo apt-key add -

# Create the /etc/apt/sources.list.d/mongodb-org-4.4.list directory
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/4.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.4.list

# Update server's local packages
sudo apt-get update

# Install mongodb
sudo apt-get install mongodb-org

# Start mongodb service
sudo systemctl start mongod.service

# Check status
sudo systemctl status mongod

# Running as expected, continue
sudo systemctl enable mongod

echo "
-----------------------
    PM2
-----------------------"

# Install pm2
sudo npm install -g pm2

# Start on system boot
sudo pm2 startup systemctl

echo "
-----------------------
    NGINX
-----------------------"

# Install NGINX
sudo apt-get install -y nginx


echo "
-----------------------
    Firewall
-----------------------"

# Allow ssh through firewall
sudo ufw allow OpenSSH

# Allow http & https through firewall
sudo ufw allow 'Nginx Full'

# Enable firewall
sudo ufw --force enable
