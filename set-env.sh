#!/usr/bin/env bash

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
