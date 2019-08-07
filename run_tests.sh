#!/bin/bash

set -e

export KUBECONFIG="$(kind get kubeconfig-path --name="kind")"

counter=0
while [[ "$(kubectl get pod --all-namespaces | grep -v Running | grep -v Completed | wc -l)" != 1 ]]; do
  counter=$((counter + 1))
  if [ "$counter" -gt "30" ]
  then
    exit 1
  fi
  kubectl get pod --all-namespaces -o wide
  echo "waiting for K8s to be ready"
  sleep 10;
done

make run_$KONG_TEST_DATABASE

counter=0
while [[ "$(kubectl get deployment kong-control-plane -n kong | tail -n +2 | awk '{print $4}')" != 1 ]]; do
  counter=$((counter + 1))
  if [ "$counter" -gt "30" ]
  then
    exit 1
  fi
  echo "waiting for Kong control plane to be ready"
  kubectl get pod --all-namespaces -o wide
  sleep 10;
done

counter=0
while [[ "$(kubectl get deployment kong-ingress-data-plane -n kong | tail -n +2 | awk '{print $4}')" != 1 ]]; do
  counter=$((counter + 1))
  if [ "$counter" -gt "30" ]
  then
    exit 1
  fi
  echo "waiting for Kong data plane to be ready"
  kubectl get pod --all-namespaces -o wide
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
