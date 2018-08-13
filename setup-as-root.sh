#!/usr/bin/env bash

# Install Apache
apt-get update
apt-get install -y apache2

# Install PHP
apt-get install -y php libapache2-mod-php php-cli
