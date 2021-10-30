#!/usr/bin/env bash

TIME_ZONE=Asia/Taipei
HOST_NAME=Dell-Puppet-Server
OLD_HOST_NAME=$(hostname)

# Show info
echo "-------------------------------------------------------------"
echo "OLD_HOST_NAME: $OLD_HOST_NAME"
echo "HOST_NAME: $HOST_NAME"
echo "Host name will be changed from $OLD_HOST_NAME to $HOST_NAME"
echo "-------------------------------------------------------------"

# Set Timezone
sudo timedatectl set-timezone $TIME_ZONE

# Set Hostname
sudo hostnamectl set-hostname $HOST_NAME

# Correct New Host Name
sudo sed -i "s/127.0.1.1   $OLD_HOST_NAME/127.0.1.1   $HOST_NAME/" /etc/hosts

# Install Chrony
sudo apt-get update
sudo apt-get -y install chrony
sudo service chrony stop
sudo service chrony start
sudo service chrony status
sleep 5
chronyc tracking

# Install Puppet Server
curl -O https://apt.puppetlabs.com/puppetlabs-release-pc1-xenial.deb
sudo dpkg -i puppetlabs-release-pc1-xenial.deb
sudo apt-get update
sudo apt-get install -y puppetserver --allow-unauthenticated
