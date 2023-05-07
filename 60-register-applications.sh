#!/usr/bin/env bash

set -eu
BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $BASEDIR


source ./functions.sh
source ./set-env.sh

#envsubst < manifest/application.yaml.tpl | kubectl apply -nargocd -f -
envsubst < manifest/application.yaml.tpl | kubectl apply -ndefault -f -
