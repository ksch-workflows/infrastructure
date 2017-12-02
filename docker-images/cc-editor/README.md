
# CaptainCasa
This document describes how to build and run a [Docker](http://www.docker.com/) image for the [CaptainCasa](http://captaincasa.org/) editor.

## Building the Docker image
```
./build-editor-image.sh -e ${INSTALL_DIR}/EnterpriseClientRISC_${VERSION}/webapplications/editor.war
```

## Start the editor
```
./start-editor.sh -d ${WORKSPACE}/${PROJECT}
./start-editor.sh -d ${WORKSPACE}/${PROJECT} -p 8081
```

## Access the editor in the browser
### Linux
```
firefox http://localhost:8080
```

### MacOS
```
open http://${DOCKER_IP}:8080
```
