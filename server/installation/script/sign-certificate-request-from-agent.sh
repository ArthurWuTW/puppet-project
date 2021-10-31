#!/usr/bin/env bash

# Show both signed and unsigned certificate
sudo /opt/puppetlabs/puppet/bin/puppet cert list --all

# Show unsigned certificate
sudo /opt/puppetlabs/puppet/bin/puppet cert list

sudo /opt/puppetlabs/puppet/bin/puppet cert sign <agent-host-name>
