#!/usr/bin/env bash

set -eu
BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $BASEDIR

source functions.sh
source set-env.sh

#set -x
set +e

./k3d cluster delete $CLUSTERS || true

#mv FluxCD-CORE FluxCD-CORE.$RANDOM
#mv FluxCD-tenant01 FluxCD-tenant01.$RANDOM
mv kubeconfig kubeconfig.$RANDOM

docker-compose --project-directory container down

