#!/bin/bash

while [[ "$(kubectl get deployment -n kong | grep 0/1 | wc -l)" != 0 ]]; do
  echo "waiting for Kong to be ready"
  sleep 10;
done

KONG_VERSION=$(kubectl exec -n kong -it $(kubectl get pods -n kong | grep kong | head -n 1 | awk '{print $1}') -- kong version | tr -d '[:space:]')

HOST="$(kubectl get nodes --namespace kong -o jsonpath='{.items[0].status.addresses[0].address}')"
echo $HOST
ADMIN_PORT=$(kubectl get svc --namespace kong kong-control-plane -o jsonpath='{.spec.ports[0].nodePort}')
echo $ADMIN_PORT
PROXY_PORT=$(kubectl get svc --namespace kong kong-ingress-data-plane -o jsonpath='{.spec.ports[0].nodePort}')
echo $PROXY_PORT

pushd kong-build-tools
    TEST_ADMIN_URI=http://$HOST:$ADMIN_PORT TEST_PROXY_URI=http://$HOST:$PROXY_PORT KONG_VERSION=$KONG_VERSION make -f Makefile run_tests
popd
