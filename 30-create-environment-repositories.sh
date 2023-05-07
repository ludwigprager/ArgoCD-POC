#!/usr/bin/env bash

#set -eu
BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $BASEDIR

source ./functions.sh
source ./set-env.sh

# 1. create the remote repo in gitea
export token=$(get-a-token)

REPO=guestbook

if ! repo-exists $token ${REPO};
then
  create-repo $token ${REPO}
fi

if [[ ! -d ${BASEDIR}/${REPO} ]]; then

  cd ${BASEDIR}
  git clone --origin poc ssh://git@${GITEA}:8022/lp/${REPO}.git
  cd ${REPO}
  cp -a ${BASEDIR}/example.${REPO}/* ${BASEDIR}/${REPO}/
  git add .
  git commit -m "Initial commit"
  git push --set-upstream poc main

fi
