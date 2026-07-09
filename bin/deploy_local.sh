#!/usr/bin/env bash

set -o errexit
set -o nounset

# default values
export KUBE_NAMESPACE=${KUBE_NAMESPACE=local-dev}

export NAME="api-directory"
export PORT=3123

echo "--- namespace: ${KUBE_NAMESPACE}"

echo "--- deploying ${NAME}"

echo $PWD

if ! kd --timeout=5m \
  -f kube_local/dev-namespace.yaml \
  -f kube_local/dev-service.yaml \
  -f kube_local/dev-ingress.yaml \
  -f kube/deployment.yaml ; then
  echo "[error] failed to deploy ${NAME}"
  exit 1
fi
