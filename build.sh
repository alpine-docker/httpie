#!/usr/bin/env bash

# Prerequisite
# Make sure you set secret enviroment variables in CI
# DOCKER_USERNAME
# DOCKER_PASSWORD

set -e

Usage() {
  echo "$0 [rebuild]"
}

install_jq() {
  # jq 1.6
  DEBIAN_FRONTEND=noninteractive
  #sudo apt-get update && sudo apt-get -q -y install jq
  curl -sL https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64 -o jq
  sudo mv jq /usr/bin/jq
  sudo chmod +x /usr/bin/jq
}

function get_latest_release() {
  curl "$CURL_OPTIONS" "https://api.github.com/repos/$1/releases/latest" | jq -r '.tag_name | ltrimstr("v")'
}

build() {

  if [[ ( "${CIRCLE_BRANCH}" == "master" ) ||( ${REBUILD} == "true" ) ]]; then

      docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD
      docker buildx create --use
      docker buildx build --progress=plain --push \
        --platform linux/arm/v7,linux/arm64/v8,linux/arm/v6,linux/amd64,linux/ppc64le,linux/s390x \
        --build-arg VERSION=${tag} \
        -t ${image}:${tag} \
        -t ${image}:latest .
  
  fi
}

image="alpine/httpie"
repo="httpie/httpie"

install_jq
tag=$(get_latest_release "${repo}")
echo "Latest release is: ${tag}"

status=$(curl -sL https://hub.docker.com/v2/repositories/${image}/tags/${tag})
echo $status

if [[ ( "${status}" =~ "not found" ) ||( ${REBUILD} == "true" ) ]]; then
   echo "build image for ${tag}"
   build
fi
