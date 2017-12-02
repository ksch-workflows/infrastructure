#!/bin/bash

# Check that dependencies for this script are installed
which readlink > /dev/null || { echo "Tool 'readlink' not installed." >&2 ; exit 1; }
which docker > /dev/null || { echo "Tool 'docker' not installed. See https://www.docker.com/get-docker" >&2 ; exit 1; }

# Evaluate script parameter
while getopts "e:" opt; do
  case $opt in
    e)
      WAR_FILE=${OPTARG}
      ;;
  esac
done

if [[ -z ${WAR_FILE} ]]; then
  echo "Script parameter -e for the path to the 'editor.war' file not specified." >&2
  exit 1
fi

if [[ ! -f ${WAR_FILE} ]]; then
  echo "The file '${WAR_FILE}' does not exist." >&2
  exit 1
fi

# Change current directory to the directory where this script resides
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd ${SCRIPT_DIR}

# Copy the war file here to be able to access it from the Dockerfile
cp ${WAR_FILE} editor.war

# Build the Docker image
docker build -t cc-editor .

# Remove the editor copy after the Docker image creation
rm editor.war

