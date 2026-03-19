#!/usr/bin/env bash

set -eu
BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $BASEDIR

set +e

source ./.env

k3d cluster delete $CLUSTERS || true

MY_RANDOM=$RANDOM
mv kubeconfig kubeconfig.${MY_RANDOM}

for app in ${APPS}; do
  mv ${app} ${app}.${MY_RANDOM}
done
mv container/gitea-data/ container/gitea-data.${MY_RANDOM}/

docker compose --project-directory container down


