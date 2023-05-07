#!/usr/bin/env bash

set -eu
BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $BASEDIR

source ./functions.sh
source ./set-env.sh

password=$(kubectl get -n argocd secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d)


echo
echo "argocd:       http://localhost:${INGRESS_PORT}/argocd"
echo "argocd login: admin : ${password}"
echo "guestbook:    http://localhost:${INGRESS_PORT}/"
echo "fleet repo:   http://$GITEA:3000/explore/repos/"
echo "swagger:      http://${GITEA}:3000/api/swagger#"
echo

