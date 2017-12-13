## Introduction

This chart bootstraps a Kong deployment on a [Kubernetes](http://kubernetes.io)
cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.4+ with Beta APIs enabled
- PV provisioner support in the underlying infrastructure (Only when persisting data)
- [Helm](https://docs.helm.sh/using_helm/#quickstart-guide) is installed and initialized

## Installing the Chart

1. Clone or download the repo and change the working directory to
`./kong-dist-kubernetes/charts/`

```bash
$ git clone git@github.com:Kong/kong-dist-kubernetes.git
$ cd ./kong-dist-kubernetes/charts
```

2. Install missing dependencies with helm dep

```bash
$ helm repo add stable https://kubernetes-charts.storage.googleapis.com/
$ helm repo add incubator https://kubernetes-charts-incubator.storage.googleapis.com/
$ helm dep list kong
$ helm dep update kong
$ helm dep build kong
```

3. Install the Kong chart
```bash
$ helm install --name <release_name> kong
```

The command deploys Kong and backing database(if enabled) on the Kubernetes cluster
using the default configuration in the `./kong/values.yaml` file. Update the
parameter's value in file to change default behaviour.

## Configuration

### General Configuration Parameters

The following tables lists the configurable parameters of the Kong chart and
their default values. For [`Cassandra`](./charts/cassandra/README.md) and
[`PostgreSQL`](./charts/postgresql/README.md), check corresponding chart README.md

| Parameter                              | Description                                                            | Default               |
| -----------------------------------    | --------------------------------------------------------------------   | -------------------   |
| kong.image                             | Kong image and version                                                 | `kong:latest`         |
| kong.nameOverride                      | Kong app name, overrides the auto generated app name                   | ``                    |
| kong.kongInstanceCount                 | Kong instance count                                                    | `1`                   |
| kong.admin.servicePort                 | TCP port on which the Kong admin service is exposed                    | `8001`                |
| kong.admin.serviceSSLPort              | Secure TCP port on which the Kong admin service is exposed             | `8444`                |
| kong.admin.containerPort               | TCP port on which Kong app listens for admin traffic                   | `8001`                |
| kong.admin.containerSSLPort            | Secure TCP port on which Kong app listens for admin traffic            | `8444`                |
| kong.admin.type                        | k8s service type exposing ports, e.g. `NodePort`                       | `NodePort`            |
| kong.admin.loadBalancerIP              | Will reuse an existing ingress static IP for the admin service         | `null`                |
| kong.admin.useTLS                      | Secure admin traffic                                                   | `true`                |
| kong.proxy.servicePort                 | TCP port on which the Kong proxy service is exposed                    | `8000`                |
| kong.proxy.serviceSSLPort              | Secure TCP port on which the Kong Proxy Service is exposed             | `8443`                |
| kong.proxy.containerPort               | TCP port on which the Kong app listens for Proxy traffic               | `8000`                |
| kong.proxy.containerSSLPort            | Secure TCP port on which the Kong app listens for Proxy traffic        | `8443`                |
| kong.proxy.type                        | k8s service type. e.g., `NodePort`, `LoadBalancer`, etc..              | `NodePort`            |
| kong.proxy.loadBalancerIP              | Will reuse an existing ingress static IP for the admin service         | `null`                |
| kong.proxy.useTLS                      | Secure Proxy traffic                                                   | `true`                |
| kong.logLevel                          | Kong [log level](https://getkong.org/docs/latest/configuration/#log_level) | `debug`           |
| kong.customConfig                      | Additional [Kong configurations](https://getkong.org/docs/latest/configuration/) |             |

### Database-specific parameters

Kong has a choice of either Postgres or Cassandra as a backend datatstore.
This chart allows you to choose either of them with the `kong.database.type`
parameter.  Postgres is chosen by default.

Additionally, this chart allows you to use your own database or spin up a new
instance by using the `postgres.enabled` or `cassandra.enabled` parameters.
Enabling both will create both databases in your cluster, but only one
will be used by Kong based on the `kong.database.type` parameter.
Postgres is enabled by default.

| Parameter                              | Description                                                            | Default               |
| -----------------------------------    | --------------------------------------------------------------------   | -------------------   |
| cassandra.enabled                      | Spin up a new cassandra cluster for Kong                               | `false`               |
| postgres.enabled                       | Spin up a new postgres instance for Kong                               | `true `               |
| kong.database.type                     | Choose either `postgres` or `cassandra`                                | `postgres`            |
| kong.database.postgres.username        | Postgres username                                                      | `kong`                |
| kong.database.postgres.database        | Postgres database name                                                 | `kong`                |
| kong.database.postgres.password        | Postgres database password                                             | `kong`                |
| kong.database.postgres.host            | Postgres database host (required if you are using your own database)   | ``                    |
| kong.database.postgres.port            | Postgres database port                                                 | `5432`                |
| kong.database.cassandra.contactPoints  | Cassandra contact points (required if you are using your own database) | ``                    |
| kong.database.cassandra.port           | Cassandra query port                                                   | `9042`                |
| kong.database.cassandra.keyspace       | Cassandra keyspace                                                     | `kong`                |
| kong.database.cassandra.replication    | Replication factor for the Kong keyspace                               | `2`                   |


## Uninstalling the Chart

To uninstall/delete the deployment:

```bash
$ helm delete <release_name>
```

The command removes all the Kubernetes components associated with the Kong chart
and deletes the release.


Note: This chart is not tested for production use.
