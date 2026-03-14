#!/usr/bin/env bash

export GITEA=$(hostname)
export KUBECONFIG=${BASEDIR:-$(pwd)}/kubeconfig

export GITEA_LP_USER=lp
export GITEA_LP_PASSWORD=geheim


export GIT_SSH_COMMAND="ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -i ${BASEDIR:-$(pwd)}/key" 



# from kcp-pot
export ARGOCD_POC_ROOT=${ARGOCD_POC_ROOT}


PATH=${ARGOCD_POC_ROOT}/bin:${ARGOCD_POC_ROOT}/bin/.krew/bin:${PATH}

alias k=$ARGOCD_POC_ROOT/bin/kubectl

# from set-env.sh

export GITEA=$(hostname)
export KUBECONFIG=${BASEDIR:-$(pwd)}/kubeconfig

export GITEA_LP_USER=lp
export GITEA_LP_PASSWORD=geheim

export GIT_SSH_COMMAND="ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -i ${BASEDIR:-$(pwd)}/key" 

export INGRESS_PORT="8123"

export CLUSTERS=""
export CLUSTER_PREFIX="argo-"
CLUSTERS="${CLUSTERS} ${CLUSTER_PREFIX}intern"
CLUSTERS="argo-intern"

APPS="guestbook helm-guestbook kustomize-guestbook podinfo"

export http_proxy=""

## Use GNU's gsed when on macOS
## If missing, you may want to install it with brew install gnu-sed
#export SED=sed
#if [[ "$(uname -o)" == "Darwin" ]]; then
#SED=gsed
#fi

export GOOS=${GOOS}
GOARCH=${GOARCH}
