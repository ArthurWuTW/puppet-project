#!/usr/bin/env bash

TIME_ZONE=Asia/Taipei
HOST_NAME=Puppet-Agent-Machine1
OLD_HOST_NAME=$(hostname)
PUPPET_MASTER_IP=10.1.1.2

# Show info
echo "-------------------------------------------------------------"
echo "OLD_HOST_NAME: $OLD_HOST_NAME"
echo "HOST_NAME: $HOST_NAME"
echo "-------------------------------------------------------------"

# Set Timezone
sudo timedatectl set-timezone $TIME_ZONE

# Add New Host Name
sudo /bin/bash -c 'echo "127.0.1.1   '$HOST_NAME'" >> /etc/hosts'

# Set New Hostname
sudo hostnamectl set-hostname $HOST_NAME
sleep 5
echo "[Warning]Bug: Cannot resolved new hostname first time"
sudo hostnamectl set-hostname $HOST_NAME

# Set Puppet Master Hostname
sudo /bin/bash -c 'echo "'$PUPPET_MASTER_IP'   puppet puppet-server" >> /etc/hosts'

# Install Chrony
sudo apt-get update
sudo apt-get -y install chrony
sudo service chrony stop
sudo service chrony start
sudo service chrony status
sleep 5
chronyc tracking

# Install Puppet Agent
curl -O https://apt.puppetlabs.com/puppetlabs-release-pc1-xenial.deb
sudo dpkg -i puppetlabs-release-pc1-xenial.deb
sudo apt-get update
sudo apt-get install -y puppet-agent --allow-unauthenticated

sudo service puppet stop
sudo service puppet start

echo "=============== Puppet Agent Installed Successfully! ============="

echo "Please wait a minute, and go to master and type"
echo ">>sudo /opt/puppetlabs/puppet/bin/puppet cert list"
echo "It should have cert request!"

