# [KONG][website-url] :heavy_plus_sign: [Kubernetes Deployment](http://kubernetes.io/)

[![Website][website-badge]][website-url]
[![Documentation][documentation-badge]][documentation-url]
[![Mailing List][mailing-list-badge]][mailing-list-url]
[![Gitter Badge][gitter-badge]][gitter-url]

[![][kong-logo]][kong-url]

Kong can easily be provisioned to Kubernetes cluster using the following steps:

1. **Initial setup**

    Download or clone the following repo:

    ```bash
    $ git clone git@github.com:Kong/kong-dist-kubernetes.git
    $ cd kong-dist-kubernetes
    ```
    If you want to run Kubernetes locally, please follow the [README](/minikube)
    and use the manifest files provided in `minikube` directory.

    Skip to step 3 if you have already provisioned a cluster and registered it
    with Kubernetes.

    Note: Included manifest files only support Kong v0.13.x, for older versions please checkout
    relevant [tag](https://github.com/Kong/kong-dist-kubernetes/tags) and modify the manifest files with Kong image which you want to try.


2.  **Deploy a GKE cluster**

    You need [gcloud](https://cloud.google.com/sdk/) and
    [kubectl](https://cloud.google.com/container-engine/docs/quickstart#install_the_gcloud_command-line_interface)
    command-line tools installed and configured to run deployment commands.
    Also make sure your Google Cloud account has `STATIC_ADDRESSES` available
    for the external access of Kong services.

    Using the `cluster.yaml` file from this repo, deploy a
    GKE cluster. Provide the following information before deploying:

    1. Desired cluster name
    2. Zone in which to run the cluster
    3. A basicauth username and password for authenticating the access to the
       cluster

    ```bash
    $ gcloud deployment-manager deployments \
        create cluster --config cluster.yaml
    ```

    Fetch credentials for above created cluster

    ```bash
    $ gcloud container clusters get-credentials NAME [--zone=ZONE, -z ZONE] [GCLOUD_WIDE_FLAG …]
    ```

    By now, you have provisioned a Kubernetes managed cluster.


3. **Deploy a Kong supported database**

    Before deploying Kong, you need to provision a Cassandra or PostgreSQL pod.

    For Cassandra, use the `cassandra.yaml` file from this repo to deploy a
    Cassandra `Service` and a `StatefulSet` in the cluster:

    ```bash
    $ kubectl create -f cassandra.yaml
    ```
    Note: Please update the `cassandra.yaml` file for the cloud you are working
    with.

    For PostgreSQL, use the `postgres.yaml` file from the kong-dist-kubernetes
    repo to deploy a PostgreSQL `Service` and a `ReplicationController` in the
    cluster:

    ```bash
    $ kubectl create -f postgres.yaml
    ```

4. **Prepare database**

    Using the `kong_migration_<postgres|cassandra>.yaml` file from this repo,
    run the migration job, jump to step 5 if Kong backing databse is up–to–date:

    ```bash
    $ kubectl create -f kong_migration_<postgres|cassandra>.yaml
    ```
    Once job completes, you can remove the pod by running following command:

    ```bash
    $ kubectl delete -f kong_migration_<postgres|cassandra>.yaml
    ```

5. **Deploy Kong**

    Using the `kong_<postgres|cassandra>.yaml` file from this
    repo, deploy Kong admin and proxy services and a `Deployment` controller to
    the cluster:

    ```bash
    $ kubectl create -f kong_<postgres|cassandra>.yaml
    ```

6. **Verify your deployments**

    You can now see the resources that have been deployed using `kubectl`:

    ```bash
    $ kubectl get all
    ```

    Once the `EXTERNAL_IP` is available for Kong Proxy and Admin services, you
    can test Kong by making the following requests:

    ```bash
    $ curl <kong-admin-ip-address>:8001
    $ curl https://<admin-ssl-ip-address>:8444
    $ curl <kong-proxy-ip-address>:8000
    $ curl https://<kong-proxy-ssl-ip-address>:8443
    ```

7. **Using Kong**

    Quickly learn how to use Kong with the
    [5-minute Quickstart](https://getkong.org/docs/latest/getting-started/quickstart/).

## Helm Chart

You can install Kong using Chart available on [Kubeapps Hub](https://hub.kubeapps.com/charts/stable/kong).

## Important Note

When deploying into a Kubernetes cluster with Deployment Manager, it is
important to be aware that deleting `ReplicationController` Kubernetes objects
**does not delete its underlying pods**, and it is your responisibility to
manage the destruction of these resources when deleting or updating a
`ReplicationController` in your configuration.


## Enterprise Support

Support, Demo, Training, API Certifications and Consulting available at http://getkong.org/enterprise.

[kong-url]: https://konghq.com/
[kong-logo]: https://cl.ly/030V1u02090Q/unnamed.png
[website-url]: https://getkong.org/
[website-badge]: https://img.shields.io/badge/GETKong.org-Learn%20More-43bf58.svg
[documentation-url]: https://getkong.org/docs/
[documentation-badge]: https://img.shields.io/badge/Documentation-Read%20Online-green.svg
[gitter-url]: https://gitter.im/Mashape/kong
[gitter-badge]: https://img.shields.io/badge/Gitter-Join%20Chat-blue.svg
[mailing-list-badge]: https://img.shields.io/badge/Email-Join%20Mailing%20List-blue.svg
[mailing-list-url]: https://groups.google.com/forum/#!forum/konglayer

