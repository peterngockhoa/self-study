#!/usr/bin/env bash

# Install Apache
apt-get update
apt-get install -y apache2

# Install PHP
apt-get install -y php libapache2-mod-php php-cli

# Install MySQL Server
export DEBIAN_FRONTEND=noninteractive
debconf-set-selections <<< "mysql-server-5.7 mysql-server/root_password password root"
debconf-set-selections <<< "mysql-server-5.7 mysql-server/root_password_again password root"
apt-get install -y mysql-server php-mysql
