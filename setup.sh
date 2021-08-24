#! bin/bash

echo "
Initializing..."
echo "
-----------------------
Author: Kevin Ramsusson
-----------------------
"


echo "Let's start with NPM & NodeJS:"

# Add latest nodejs using nodesource current version
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -

# Install nodejs, npm
sudo apt-get install -y nodejs

# NOTE: IF DEBIAN COMMENT LINES ABOVE, UNCOMMENT BELOW
# curl -fsSL https://deb.nodesource.com/setup_lts.x | bash -
# apt-get install -y nodejs

echo "Done with NPM & NodeJS, let's continue..."
echo "-----------------"
