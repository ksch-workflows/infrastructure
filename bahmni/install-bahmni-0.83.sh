#!/bin/bash

yum install https://dl.bintray.com/bahmni/rpm/rpms/bahmni-installer-0.83-142.noarch.rpm -y
bahmni --help || exit 1
curl -L https://goo.gl/sk52Gx >> /etc/bahmni-installer/setup.yml
bahmni -i local install
yum list installed | grep bahmni

