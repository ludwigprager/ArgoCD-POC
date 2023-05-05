#!/usr/bin/env bash

set -eu
BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $BASEDIR

source ./functions.sh
source ./set-env.sh


./20-start-gitea.sh
#./30-create-environment-repositories.sh
./40-start-a-k8s-cluster.sh
./50-install-argocd-k8s.sh
