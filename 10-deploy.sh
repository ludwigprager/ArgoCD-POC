#!/usr/bin/env bash

set -eu
BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $BASEDIR

./14-env.sh
./15-install.sh

./20-start-gitea.sh
./30-create-environment-repositories.sh
./40-start-a-k8s-cluster.sh
./50-install-argocd-k8s.sh
./60-register-applications.sh

# ./test-ingress.sh
