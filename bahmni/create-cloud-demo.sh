#!/bin/bash

SCRIPT_DIR=$(dirname "$0")

if [ -z $DIGITAL_OCEAN_TOKEN ]; then
  echo "Missing environment variable 'DIGITAL_OCEAN_TOKEN'."
  exit 1
fi


function create_droplet {
  DROPLET_ID=$(curl -X POST -H "Content-Type: application/json" -H "Authorization: Bearer ${DIGITAL_OCEAN_TOKEN}" -d '{"name":"kch-test-droplet","region":"fra1","size":"4gb","image":"centos-6-x64","ssh_keys"
  :[5597193],"backups":false,"ipv6":false,"user_data":null,"private_networking":true,"volumes": null,"tags":["web"]}' "https://api.digitalocean.com/v2/droplets" | jq '.droplet.id')
  sleep 70

  echo $DROPLET_ID
}

function get_droplet_ip {
  IP_ADDRESS=$(curl -X GET -H "Content-Type: application/json" -H "Authorization: Bearer $DIGITAL_OCEAN_TOKEN" "https://api.digitalocean.com/v2/droplets/$1" | jq '.droplet.networks.v4[1].ip_address')
  IP_ADDRESS=${IP_ADDRESS//\"/} # Workaround for gedit syntax highlighting: "

  echo $IP_ADDRESS
}

function install_bahmni {
  time ssh root@$1 'bash -s' < $SCRIPT_DIR/install-bahmni-0.87.sh
}

DROPLET_ID=$(create_droplet)
IP_ADDRESS=$(get_droplet_ip $DROPLET_ID)

install_bahmni $IP_ADDRESS

echo "Finished installation of Bahmni on $IP_ADDRESS"






