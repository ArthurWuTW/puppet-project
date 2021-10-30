#!/usr/bin/env bash

sudo /opt/puppetlabs/puppet/bin/puppet cert list
sudo /opt/puppetlabs/puppet/bin/puppet cert sign <agent-host-name>
