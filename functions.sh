#!/usr/bin/env bash


function get-a-token() {
  local response=$(curl -s -H "Content-Type: application/json" \
  -d "{\"name\":\"${RANDOM}\"}" \
  -u ${GITEA_LP_USER}:${GITEA_LP_PASSWORD} http://$GITEA:3000/api/v1/users/lp/tokens)

  local token=$(echo $response | jq -r .sha1)
  printf ${token}
}

function repo-exists() {
  local token=$1
  local repo_name=$2

  result=$(
    curl -s -X 'GET' \
    "http://${GITEA}:3000/api/v1/repos/search?q=${repo_name}" \
    -H 'accept: application/json'
  )

  data=$(echo $result | yq -r '.data[]')

  [[ ! -z "$data"  ]]

}

function create-repo() {
  local token=$1
  local repo_name=$2

  #curl -X POST "http://${GITEA}:3000/api/v1/user/repos?access_token=$token" \
  curl -X POST "http://${GITEA}:3000/api/v1/user/repos" \
    -u ${GITEA_LP_USER}:${GITEA_LP_PASSWORD} \
    -H "accept: application/json" \
    -H "content-type: application/json" \
    -d "{\"name\":\"$repo_name\" }"
}

#function kf() {
#  k get $(kubectl api-resources | grep -i flux | cut -d' ' -f1 | tr '\n' ',' | sed 's/,$//g') -A;
#}
#export -f kf

get-primary-ip() {
  # no hostname -I on macOS
  if [ "$(uname -o)" == Darwin ]; then
    local PRIMARY_IP=$(ifconfig en0 | awk '/inet / {print $2; }' | egrep -v 127.0.0.1 | head -1)
  else
    local PRIMARY_IP=$(hostname -I | cut -d " " -f1)
  fi
  printf ${PRIMARY_IP}
}

function cluster-exists() {
  local cluster_name=$1
  #local K3D=$(get-k3d-path)
  local K3D=${BASEDIR}/k3d

  # need a blank after name. Else prefix would work, too.
  COUNT=$(${K3D} cluster list | grep ^${cluster_name}\  | wc -l)
  if [[ $COUNT -eq 0 ]]; then
    # 1 = false
    return 1
  else
    # 0 = true
    return 0
  fi
}

export -f cluster-exists

