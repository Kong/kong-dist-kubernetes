## Introduction

This chart bootstraps a Kong deployment on a [Kubernetes](http://kubernetes.io)
cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.4+ with Beta APIs enabled
- PV provisioner support in the underlying infrastructure (Only when persisting data)
- [Helm](https://docs.helm.sh/using_helm/#quickstart-guide) is installed and initialized

## Installing the Chart

1. Change working directory to  `./charts/`
```bash
$ cd ./charts
```

2. Install the Kong chart
```bash
$ helm install --name <release_name> kong
```

The command deploys Kong and backing database(if enabled) on the Kubernetes cluster
using the default configuration in the `./kong/values.yaml` file. Update the
parameter's value in file to change default behaviour.

## Uninstalling the Chart

To uninstall/delete the deployment:

```bash
$ helm delete <release_name>
```

The command removes all the Kubernetes components associated with the Kong chart
and deletes the release.


Note: This chart is not tested for production use.






