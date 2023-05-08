#!/usr/bin/env bash

#set -eu
set -x
BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $BASEDIR

source ./functions.sh
source ./set-env.sh

PRIMARY_IP=$(get-primary-ip)

#curl http://${PRIMARY_IP}:${INGRESS_PORT}/argocd/
#curl http://${PRIMARY_IP}:${INGRESS_PORT}/
curl http://${PRIMARY_IP}:${INGRESS_PORT}/guestbook
curl http://${PRIMARY_IP}:${INGRESS_PORT}/helm-guestbook

