These deployment YAML files are adapted for use with Kong Enterprise Edition (EE) trials.

Because Kong EE is not available on the public Docker registry, you must make your own Kong 
EE Docker images available to Kubernetes. To do so using the Google Cloud Platform Container Registry:

```bash
$ docker load -i /tmp/kong-docker-enterprise-edition.tar.gz
$ docker images
$ docker tag <image ID> gcr.io/<project ID>/kong-ee
$ gcloud docker -- push gcr.io/<project ID>/kong-ee:latest
```

Before deploying Kong EE, you must edit the YAML files to use your Kong EE image 
(replace `image: kong-ee` with `gcr.io/<project ID>/kong-ee`) and your Kong EE 
License File (replace `YOUR_LICENSE_HERE` with your license string).

See more details at https://getkong.org/install/kubernetes/
