#!/usr/bin/env bash

set -eu
BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $BASEDIR


source ./functions.sh
source ./set-env.sh

wget -nc https://github.com/argoproj/argo-cd/raw/v2.7.1/manifests/install.yaml
# modify args to argocd server:
my_args=" \ \ \ \ \ \ \ \ - --insecure\n        - --rootpath\n        - /argocd"
sed "/.*\/usr\/local\/bin\/argocd-server/a ${my_args}" install.yaml > install.yaml.modified


kubectl --context=k3d-argo-intern \
  apply -f install.yaml.modified -n argocd \
  || true

kubectl --context=k3d-argo-intern \
  apply -f manifest/ingress.argocd.yaml \
  || true

# -n argocd \

#POD=$(kubectl get pod -l app.kubernetes.io/name=argocd-server -o jsonpath="{.items[0].metadata.name}")

while [[ $(kubectl get pods -nargocd -l app.kubernetes.io/name=argocd-server \
           -o 'jsonpath={..status.conditions[?(@.type=="Ready")].status}') \
           != "True" \
      ]]; do 
  echo "waiting for argo server to get ready" && sleep 10; 
done

echo curl http://localhost:${INGRESS_PORT}/argocd

sensible-browser http://localhost:${INGRESS_PORT}/argocd &

./print-console-links.sh 
