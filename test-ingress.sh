#!/usr/bin/env bash

set -eu
#set -x
BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $BASEDIR

source ./.env

PRIMARY_IP=$(get-primary-ip)

#curl http://${PRIMARY_IP}:${INGRESS_PORT}/argocd/
#curl http://${PRIMARY_IP}:${INGRESS_PORT}/
curl --fail http://${PRIMARY_IP}:${INGRESS_PORT}/podinfo
curl --fail http://${PRIMARY_IP}:${INGRESS_PORT}/guestbook
curl --fail http://${PRIMARY_IP}:${INGRESS_PORT}/helm-guestbook
curl --fail http://${PRIMARY_IP}:${INGRESS_PORT}/kustomize-guestbook

echo "all URLs processed"

