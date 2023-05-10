#!/usr/bin/env bash

set -eu
BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $BASEDIR

source ./functions.sh
source ./set-env.sh

$SED -i 's@tag: 6.3.5@tag: 6.3.6@g' podinfo/values.yaml

pushd podinfo/

git add .

git commit -m "Upgrade to 6.3.6" || true

git push
popd

exit 0

kubectl config use-context k3d-argo-intern
while true; do
  clear
  kubectl get events --sort-by='.metadata.creationTimestamp' -A
# ./flux get all
  kubectl get po -npodinfo  -l app.kubernetes.io/name=podinfo -o=json | jq -r '.items[0].spec.containers[0].image'
  sleep 5
done
