KONG_BUILD_TOOLS?=2.0.3
KONG_TEST_DATABASE?=postgres

setup-kong-build-tools:
	-rm -rf kong-build-tools; \
	git clone https://github.com/Kong/kong-build-tools.git; fi
	cd kong-build-tools; \
	git reset --hard ${KONG_BUILD_TOOLS}; \

test:
	./run_tests.sh

k8s_setup:
	kubectl apply -f kong-namespace.yaml

run_dbless: k8s_setup
	-kubectl create configmap kongdeclarative -n kong --from-file=declarative.yaml
	kubectl create configmap kongdeclarative -n kong --from-file=declarative.yaml -o yaml --dry-run | kubectl replace -n kong -f -
	kubectl apply -f kong-dbless.yaml

cleanup:
	-kubectl -n kong delete -f kong-dbless.yaml
	-kubectl -n kong delete configmap kongdeclarative
	kubectl delete -f kong-namespace.yaml