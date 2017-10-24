#!/bin/bash
# https://bahmni.atlassian.net/wiki/display/BAH/Install+Bahmni+on+CentOS

# Install Bahmni installer
yum install https://dl.bintray.com/bahmni/rpm/rpms/bahmni-installer-0.87-81.noarch.rpm -y
bahmni --help || exit 1

# Create config file
cat > /etc/bahmni-installer/setup.yml <<- EOM
timezone: Europe/Berlin
implementation_name: default
selinux_state: disabled
postgres_repo_rpm_name: pgdg-centos92-9.2-7.noarch.rpm
EOM

# Start Bahmni installation
#bahmni -i local install
bahmni -i local --skip openerp,bahmni-erp-connect,bahmni-reports install 

yum list installed | grep bahmni
}
