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

# [OUTDATED] Add version 18 (latest stable, check nodejs.org so it is still correct)
# curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash - &&\
# sudo apt-get install -y nodejs

# NEW
sudo apt-get update
sudo apt-get install -y ca-certificates curl gnupg
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg

NODE_MAJOR=18
echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list

sudo apt-get update
sudo apt-get install nodejs -y

echo "
-----------------------
    MongoDB
-----------------------"
# https://www.digitalocean.com/community/tutorials/how-to-install-mongodb-on-ubuntu-20-04

# Import mongodb key and add to trusted keys
# curl -fsSL https://www.mongodb.org/static/pgp/server-4.4.asc | sudo apt-key add -

# New for mongodb 5
wget -qO - https://www.mongodb.org/static/pgp/server-5.0.asc | sudo apt-key add -


# Create the /etc/apt/sources.list.d/mongodb-org-4.4.list directory
# echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/4.4 multiverse" | sudo tee 
/etc/apt/sources.list.d/mongodb-org-4.4.list

# Also updated for mongodb 5
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/5.0 multiverse" | sudo tee 
/etc/apt/sources.list.d/mongodb-org-5.0.list

# Update server's local packages
sudo apt-get update

# Install mongodb
sudo apt-get install -y mongodb-org

# Start mongodb service
sudo systemctl start mongod.service

# Check status
sudo systemctl status mongod

# Running as expected, continue
sudo systemctl enable mongod

echo "
-----------------------
    POSTGRES & REDIS
-----------------------"
# POSTGRES
# https://www.digitalocean.com/community/tutorials/how-to-install-postgresql-on-ubuntu-22-04-quickstart
sudo apt update

sudo apt install postgresql postgresql-contrib

# start setting up
sudo -u postgres psql

sudo apt install redis-server

# test it
redis-cli PING

echo "
-----------------------
    PM2
-----------------------"

# Install pm2
sudo npm install -g pm2

# Start on system boot
#sudo pm2 startup systemctl

# New updated since ctl not working
pm2 startup

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
