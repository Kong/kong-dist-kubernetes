
k8s_setup:
	kubectl apply -f kong-namespace.yaml
	-./setup_certificate.sh

run_cassandra: k8s_setup
	kubectl apply -f cassandra-service.yaml
	kubectl apply -f cassandra-statefulset.yaml
	kubectl -n kong apply -f kong-control-plane-cassandra.yaml

run_postgres: k8s_setup
	kubectl -n kong apply -f postgres.yaml
	kubectl -n kong apply -f kong-control-plane-postgres.yaml
	kubectl -n kong apply -f kong-ingress-data-plane-postgres.yaml

cleanup:
	-kubectl delete -f cassandra-service.yaml
	-kubectl delete -f cassandra-statefulset.yaml
	-kubectl -n kong delete -f kong-control-plane-cassandra.yaml
	-kubectl -n kong delete -f postgres.yaml
	-kubectl -n kong dele 
 
 
export HOST=`kubectl get nodes --namespace default -o jsonpath='{.items[0].status.addresses[0].address}'` 
export PROXY_PORT=`kubectl get svc --namespace kong kong-ingress-data-plane -o jsonpath='{.spec.ports[0].nodePort}'` 
 
 
export HOST=`kubectl get nodes --namespace default -o jsonpath='{.items[0].status.addresses[0].address}'` 
export PROXY_PORT=`kubectl get svc --namespace kong kong-ingress-data-plane -o jsonpath='{.spec.ports[0].nodePort}'`te -f kong-control-plane-postgres.yaml
	-kubectl -n kong delete -f kong-ingress-data-plane-postgres.yaml
	-kubectl certificate approve kong-control-plane.kong.svc
	-kubectl delete csr kong-control-plane.kong.svc
	kubectl delete -f kong-namespace.yaml