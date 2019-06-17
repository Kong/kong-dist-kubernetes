# [KONG][website-url] :heavy_plus_sign: [Kubernetes Deployment](http://kubernetes.io/)

[![Website][website-badge]][website-url]
[![Documentation][documentation-badge]][documentation-url]
[![Discussion][discussion-badge]][discussion-url]

[![][kong-logo]][website-url]

Kong or Kong Enterprise can easily be provisioned 
on a Kubernetes cluster - see [Kong on Kubernetes](https://docs.konghq.com/install/kubernetes) for all the details.

## Important Note

When deploying into a Kubernetes cluster with Deployment Manager, it is
important to be aware that deleting `ReplicationController` Kubernetes objects
**does not delete its underlying pods**, and it is your responisibility to
manage the destruction of these resources when deleting or updating a
`ReplicationController` in your configuration.

## Kong Enterprise

Kong Enterprise is our powerful offering for larger organizations in need of security, monitoring, 
compliance, developer onboarding, higher performance, granular access and a dashboard to manage 
Kong easily. Learn more at https://konghq.com/kong-enterprise/.

## Usage

Assuming the prerequisite of access to a k8s cluster via kubectl

```
make run_<postgres|cassandra>
```

Expose the admin api
```
kubectl port-forward -n kong svc/kong-control-plane 8001:8001
curl localhost:8001
```

Access the proxy
```
export HOST=$(kubectl get nodes --namespace default -o jsonpath='{.items[0].status.addresses[0].address}')
export PROXY_PORT=$(kubectl get svc --namespace kong kong-ingress-data-plane -o jsonpath='{.spec.ports[0].nodePort}')
curl $HOST:$PROXY_PORT
```

Cleanup
```
make cleanup
```

## Usage

Assuming the prerequisite of access to a k8s cluster via kubectl

```
make run_<postgres|cassandra|dbless>
```

Expose the admin api
```
kubectl port-forward -n kong svc/kong-control-plane 8001:8001 &
curl localhost:8001
```

Access the proxy
```
export HOST=$(kubectl get nodes --namespace default -o jsonpath='{.items[0].status.addresses[0].address}')
export PROXY_PORT=$(kubectl get svc --namespace kong kong-ingress-data-plane -o jsonpath='{.spec.ports[0].nodePort}')
curl $HOST:$PROXY_PORT
```

If using dbless/declarative the `declarative.yaml` file is mounted as a config
map onto the Kong containers. We use the md5sum of `declarative.yaml` file to
update the deployment but per [Facilitate ConfigMap rollouts / management](https://github.com/kubernetes/kubernetes/issues/22368) for production setups
one would might be best to use helm, kustomize or [reloader](https://github.com/stakater/reloader).

Cleanup
```
make cleanup
```

[kong-logo]: https://konghq.com/wp-content/uploads/2017/10/kong-cover@2x-1.png
[website-url]: https://konghq.com/
[website-badge]: https://img.shields.io/badge/GETKong.org-Learn%20More-43bf58.svg
[documentation-url]: https://docs.konghq.com/
[documentation-badge]: https://img.shields.io/badge/Documentation-Read%20Online-green.svg
[discussion-badge]: https://img.shields.io/badge/Discuss-Join%20Kong%20Nation-blue.svg
[discussion-url]: https://discuss.konghq.com/
