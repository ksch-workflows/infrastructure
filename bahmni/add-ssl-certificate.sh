#!/bin/bash

# See https://bahmni.atlassian.net/wiki/display/BAH/Configure+Valid+SSL+Certificates

KCH_DOMAIN=kch.experimental-software.com

# Install dependencies
yum install git -y

# Request certificate from Let's Encrypt
cd /etc
sudo git clone https://github.com/letsencrypt/letsencrypt
cd letsencrypt
kill $(lsof -t -i:443)
./letsencrypt-auto certonly --standalone -d ${KCH_DOMAIN} --debug

# Configure certificate for Apache
SSL_CONFIG=/etc/httpd/conf.d/ssl.conf
perl -pi -e "s/^SSLCertificateFile.*$/SSLCertificateFile \/etc\/letsencrypt\/live\/${KCH_DOMAIN}\/cert.pem/g" ${SSL_CONFIG}
perl -pi -e "s/^SSLCertificateKeyFile.*$/SSLCertificateKeyFile \/etc\/letsencrypt\/live\/${KCH_DOMAIN}\/privkey.pem /g" ${SSL_CONFIG}
perl -pi -e "s/^SSLCertificateChainFile.*$/SSLCertificateChainFile \/etc\/letsencrypt\/live\/${KCH_DOMAIN}\/chain.pem/g" ${SSL_CONFIG}

# Restart web server
bahmni -i local restart








