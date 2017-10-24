#!/bin/bash

# https://bahmni.atlassian.net/wiki/display/BAH/Install+Bahmni+on+CentOS

usage() {
	echo "Utility script for installing Bahmni"
	exit 1;
}

BAHMNI_CONFIG_URL="http://tiny.cc/defaultsetup"
BAHMNI_INVENTORY=local

while getopts ":c:v:b:i" o; do
	case "${o}" in
    c)
      BAHMNI_CONFIG_URL=${OPTARG}
      ;;
    v)
      VERSION=${OPTARG}
      ;;
    b)
      BUILD_NUMBER=${OPTARG}
      ;;
    i)
      BAHMNI_INVENTORY=${OPTARG}
      ;;
		*)
			usage
			;;
	esac
done

# Workaround for https://gist.github.com/jmewes/6f3324c1fe72332e8885cc45c56f5229
yum install -y ftp://195.220.108.108/linux/Mandriva/devel/cooker/x86_64/media/contrib/release/mx-1.4.5-1-mdv2012.0.x86_64.rpm
yum install -y bahmni-erp

if [[ -z "${BAHMNI_CONFIG_URL}" || -z "${VERSION}" || -z "${BUILD_NUMBER}" ]]; then
	echo "Missing parameter."
	usage
fi

yum install https://dl.bintray.com/bahmni/rpm/rpms/bahmni-installer-${VERSION}-${BUILD_NUMBER}.noarch.rpm -y
bahmni --help || exit 1
curl -L ${BAHMNI_CONFIG_URL} > /etc/bahmni-installer/setup.yml

echo "Using the following configuration for the installation:"
cat /etc/bahmni-installer/setup.yml

echo "Starting the installation"
bahmni -i ${BAHMNI_INVENTORY} install

echo "Installation finished"
yum list installed | grep bahmni
