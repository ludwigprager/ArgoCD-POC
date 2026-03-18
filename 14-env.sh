#!/usr/bin/env bash

set -euo pipefail
BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $BASEDIR

mkdir -p bin/

export BASEDIR
export ARGOCD_POC_ROOT=$(git rev-parse --show-toplevel)
export GOOS="$( uname | tr '[:upper:]' '[:lower:]' | grep -E 'linux|darwin' )"
export GOARCH="$( uname -m | sed 's/x86_64/amd64/ ; s/aarch64/arm64/' | grep -E 'amd64|arm64' )"

envsubst < ./misc/env.tpl > .env
cat misc/utils.sh >> .env
