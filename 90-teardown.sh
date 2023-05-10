#!/usr/bin/env bash

set -eu
BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $BASEDIR

source functions.sh
source set-env.sh

#set -x
set +e

./k3d cluster delete $CLUSTERS || true

MY_RANDOM=$RANDOM
mv kubeconfig kubeconfig.${MY_RANDOM}

for app in ${APPS}; do
  mv ${app} ${app}.${MY_RANDOM}
done

docker-compose --project-directory container down

