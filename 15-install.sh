#!/usr/bin/env bash

set -euo pipefail
BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $BASEDIR

source .env

mkdir -p bin/

[[ -n "${GOOS}" ]] || { echo "Unsupported OS: $(uname)" 1>&2 ; exit 1 ; }
[[ -n "${GOARCH}" ]] || { echo "Unsupported platform: $(uname -m)" 1>&2 ; exit 1 ; }


KIND_VERSION=0.31.0
if [[ ! -f "${ARGOCD_POC_ROOT}/bin/.checkpoint-kind" ]]; then
  echo "🚀 Downloading kind"
  curl -Lo "${ARGOCD_POC_ROOT}/bin/kind" "https://github.com/kubernetes-sigs/kind/releases/download/v${KIND_VERSION}/kind-${GOOS}-${GOARCH}"
  chmod +x "${ARGOCD_POC_ROOT}/bin/kind"
  touch "${ARGOCD_POC_ROOT}/bin/.checkpoint-kind"
fi

KUBECTL_VERSION=1.35.0
if [[ ! -f "${ARGOCD_POC_ROOT}/bin/.checkpoint-kubectl" ]]; then
  echo "🚀 Downloading kubectl"
  curl -Lo "${ARGOCD_POC_ROOT}/bin/kubectl" "https://dl.k8s.io/v${KUBECTL_VERSION}/bin/${GOOS}/${GOARCH}/kubectl"
  chmod +x "${ARGOCD_POC_ROOT}/bin/kubectl"
  touch "${ARGOCD_POC_ROOT}/bin/.checkpoint-kubectl"
fi


HELM_VERSION=3.17.0
if [[ ! -f "${ARGOCD_POC_ROOT}/bin/.checkpoint-helm" ]]; then
  echo "🚀 Downloading Helm"
  curl -Lo "${ARGOCD_POC_ROOT}/bin/helm.tar.gz" "https://get.helm.sh/helm-v${HELM_VERSION}-${GOOS}-${GOARCH}.tar.gz"
  mkdir -p "${ARGOCD_POC_ROOT}/bin/helm-temp"
  tar -xzf "${ARGOCD_POC_ROOT}/bin/helm.tar.gz" -C "${ARGOCD_POC_ROOT}/bin/helm-temp" --strip-components=1
  mv "${ARGOCD_POC_ROOT}/bin/helm-temp/helm" "${ARGOCD_POC_ROOT}/bin/helm"
  chmod +x "${ARGOCD_POC_ROOT}/bin/helm"
  rm -rf "${ARGOCD_POC_ROOT}/bin/helm.tar.gz" "${ARGOCD_POC_ROOT}/bin/helm-temp"
  touch "${ARGOCD_POC_ROOT}/bin/.checkpoint-helm"
fi

YQ_VERSION=v4.49.2

if [[ ! -f "${ARGOCD_POC_ROOT}/bin/.checkpoint-yq" ]]; then
  echo "🚀 Downloading yq"
  curl -Lo "${ARGOCD_POC_ROOT}/bin/yq" \
    "https://github.com/mikefarah/yq/releases/download/${YQ_VERSION}/yq_${GOOS}_${GOARCH}"

  chmod +x "${ARGOCD_POC_ROOT}/bin/yq"
  touch "${ARGOCD_POC_ROOT}/bin/.checkpoint-yq"
fi

if [[ ! -f ./bin/k3d ]]; then
  export K3D_INSTALL_DIR="${BASEDIR:-$(pwd)}/bin"
  export USE_SUDO='false'
  export PATH=$PATH:${K3D_INSTALL_DIR}
  curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | TAG=v5.9.0 bash
fi

