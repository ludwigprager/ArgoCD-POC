#!/usr/bin/env bash

set -eu
BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $BASEDIR


source ./functions.sh
source ./set-env.sh

export PRIMARY_IP=$(get-primary-ip)

export REPO=guestbook
envsubst < manifest/application.yaml.tpl | kubectl apply -nargocd -f -

export REPO=helm-guestbook
envsubst < manifest/application.yaml.tpl | kubectl apply -nargocd -f -
