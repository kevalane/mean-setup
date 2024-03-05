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

# NEW
sudo apt-get update
sudo apt-get install -y ca-certificates curl gnupg
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg

NODE_MAJOR=20
echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list

sudo apt-get update
sudo apt-get install nodejs -y

echo "
-----------------------
    MongoDB
-----------------------"
# https://www.digitalocean.com/community/tutorials/how-to-install-mongodb-on-ubuntu-20-04

# ARTICLE:
# https://www.mongodb.com/docs/manual/tutorial/install-mongodb-on-ubuntu/

# install if not installed already (probably is)
sudo apt-get install gnupg curl

curl -fsSL https://www.mongodb.org/static/pgp/server-7.0.asc | sudo gpg -o /usr/share/keyrings/mongodb-server-7.0.gpg --dearmor

echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-7.0.list

sudo apt-get update

sudo apt-get install -y mongodb-org

sudo systemctl start mongod

# If unit mongod.service not found
sudo systemctl daemon-reload

sudo systemctl status mongod

sudo systemctl enable mongod

sudo systemctl stop mongod

sudo systemctl restart mongod

mongosh

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
