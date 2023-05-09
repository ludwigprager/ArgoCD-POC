#!/usr/bin/env bash

set -eu
BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $BASEDIR

source ./functions.sh
source ./set-env.sh

# 1. create the remote repo in gitea
token=$(get-a-token)

for app in ${APPS}; do

  if ! repo-exists $token ${app};
  then
    create-repo $token ${app}
  fi

  if [[ ! -d ${BASEDIR}/${app} ]]; then

    cd ${BASEDIR}
    git clone --origin poc ssh://git@${GITEA}:8022/lp/${app}.git
    cd ${app}
    cp -a ${BASEDIR}/example.${app}/* ${BASEDIR}/${app}/
    git add .
    git commit -m "Initial commit"
    git push --set-upstream poc main

  fi

done
