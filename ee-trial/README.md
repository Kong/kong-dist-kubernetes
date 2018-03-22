These deployment YAML files are adapted for use with Enterprise Edition trials, and enable Enterprise-only features (the Admin GUI, Developer Portal, and Vitals).

Because Enterprise Edition is not available on the public Docker registry, you must make your own images available to Kubernetes. To do so using the Google Cloud Platform Container Registry:

```bash
$ docker load -i /tmp/kong-docker-enterprise-edition.tar.gz
$ docker images
$ docker tag <image ID> gcr.io/<project ID>/kong-ee
$ gcloud docker -- push gcr.io/<project ID>/kong-ee:latest
```

Before deploying, you must edit the YAML files to use your image (replace `image: kong-ee` with `gcr.io/<project ID>/kong-ee`) and Enterprise license (replace `YOUR_LICENSE_HERE` with your license string).
