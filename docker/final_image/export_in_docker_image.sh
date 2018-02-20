#!/usr/bin/env bash

DOCKER_HUB_PROGECT=dgls/footcourtproxy-`uname -m`

# trap ctrl-c and call ctrl_c()
trap ctrl_c INT

function ctrl_c() {
        printf "** Trapped CTRL-C, bye!\n"
        rm -rf FootCourtProxy/
        exit;
}



printf "** Hi! I will help you to create docker image from your current source code\n"

if [ -z "$1" ]
  then
    read -r -p "** Please, enter version: ${DOCKER_HUB_PROGECT}:" version
  else
    version=$1
fi
echo "** I will build ${DOCKER_HUB_PROGECT}:${version}"

printf "** I copy your current code...\n"


mkdir -p FootCourtProxy/front/
mkdir -p FootCourtProxy/proxy/
mkdir -p FootCourtProxy/docker/

set -x
cp -r ../../../jenkins/README.md FootCourtProxy/README.md

set +x

###
#
#код по защите исходников
#
###

printf "** I'm starting to build an image, it may take some time ...\n"
docker build . -f Dockerfile -t ${DOCKER_HUB_PROGECT}:${version} --no-cache

if [ $? -eq 0 ]; then
    printf "** Docker image is ready you can push it to the docker hub:\n         docker push ${DOCKER_HUB_PROGECT}:${version} \n"
    printf "** Also, do not forget push the latest:\n         docker tag ${DOCKER_HUB_PROGECT}:${version} ${DOCKER_HUB_PROGECT}:latest \n         docker push ${DOCKER_HUB_PROGECT}:latest \n "
else
      printf "** Something go wrong\n"
fi

rm -rf FootCourtProxy/
