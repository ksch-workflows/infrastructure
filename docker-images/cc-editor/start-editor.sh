#!/bin/bash

# Evaluate script parameters
HOST_PORT_NUMBER=8080

while getopts "d: p:" opt; do
  case $opt in
    d)
      PROJECT_DIRECTORY=${OPTARG}
      ;;
    p)
      HOST_PORT_NUMBER=${OPTARG}
      ;;
  esac
done

if [[ -z ${PROJECT_DIRECTORY} ]]; then
  echo "Script parameter -d for project directory not specified." >&2
  exit 1
fi

if [[ ! -d ${PROJECT_DIRECTORY} ]]; then
  echo "Project directory '${PROJECT_DIRECTORY}' does not exist." >&2
  exit 1
fi

# Transform relative path declaration to absolute path to file
PROJECT_DIRECTORY=$(readlink -f ${PROJECT_DIRECTORY})

# Start the editor
docker run --rm  -v ${PROJECT_DIRECTORY}:/home/workspace -p ${HOST_PORT_NUMBER}:8080 cc-editor

