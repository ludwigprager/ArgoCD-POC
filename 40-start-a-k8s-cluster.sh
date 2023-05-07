#!/usr/bin/env bash

set -eu
BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $BASEDIR

source ./functions.sh
source ./set-env.sh


# install k3d
if [[ ! -f ./k3d ]]; then
  export K3D_INSTALL_DIR=${BASEDIR:-$(pwd)}
  export USE_SUDO='false'
  export PATH=$PATH:${BASEDIR} # k3d install fails otherwise
  curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | TAG=v5.4.9 bash
fi


for cluster in $CLUSTERS; do
  if ! cluster-exists $cluster; then

  envsubst < k3d-config/${cluster}.yaml.tpl > k3d-config/${cluster}.yaml

  ./k3d cluster create $cluster \
    --config k3d-config/$cluster.yaml \
    --wait 

  fi

kubectl apply -f manifest/namespace.yaml

# create endpoint in cluster pointing to my primary IP address
export PRIMARY_IP=$(get-primary-ip)
envsubst < manifest/external-service.yaml.tpl | kubectl apply -nargocd -f -

done



