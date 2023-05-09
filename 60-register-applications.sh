#!/usr/bin/env bash

set -eu
BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $BASEDIR


source ./functions.sh
source ./set-env.sh

export PRIMARY_IP=$(get-primary-ip)

export app
for app in ${APPS}; do
  envsubst < manifest/application.yaml.tpl | kubectl apply -nargocd -f -
done

kubectl --context=k3d-argo-intern \
  apply -f manifest/ingressroute.yaml
