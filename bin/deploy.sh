#!/usr/bin/env bash

set -o errexit
set -o nounset

# default values
export DRONE_DEPLOY_TO=${DRONE_DEPLOY_TO:?'[error] Please specify which cluster to deploy to.'}
export KUBE_NAMESPACE=${KUBE_NAMESPACE=cto-dev}
export KUBE_CERTIFICATE_AUTHORITY=https://raw.githubusercontent.com/UKHomeOffice/acp-ca/master/${DRONE_DEPLOY_TO}.crt

export NAME="api-directory"
export PORT=3123

case ${DRONE_DEPLOY_TO} in
  'acp-notprod')
    export KUBE_SERVER="https://kube-api-notprod.notprod.acp.homeoffice.gov.uk"
    export KUBE_TOKEN=${KUBE_TOKEN_ACP_NOTPROD}
    ;;
    'acp-test')
    export KUBE_SERVER="https://kube-api-test.testing.acp.homeoffice.gov.uk"
    export KUBE_TOKEN=${KUBE_TOKEN_ACP_TEST}
    ;;
esac

echo "--- kube api url: ${KUBE_SERVER}"
echo "--- namespace: ${KUBE_NAMESPACE}"

echo "--- deploying ${NAME}"
if ! kd --timeout=5m \
  -f kube/networkpolicy-internal.yaml \
  -f kube/networkpolicy-external.yaml \
  -f kube/service.yaml \
  -f kube/ingress-internal.yaml \
  -f kube/ingress-external.yaml \
  -f kube/deployment.yaml ; then
  echo "[error] failed to deploy ${NAME}"
  exit 1
fi
