# [KONG][website-url] :heavy_plus_sign: [Kubernetes Deployment](http://kubernetes.io/)

[![Website][website-badge]][website-url]
[![Documentation][documentation-badge]][documentation-url]
[![Discussion][discussion-badge]][discussion-url]

[![][kong-logo]][website-url]

Kong Community Edition (CE) or Kong Enterprise Edition (EE) can easily be provisioned 
on a Kubernetes cluster - see [Kong on Kubernetes](https://getkong.org/install/kubernetes/) for all the details.

## Important Note

When deploying into a Kubernetes cluster with Deployment Manager, it is
important to be aware that deleting `ReplicationController` Kubernetes objects
**does not delete its underlying pods**, and it is your responisibility to
manage the destruction of these resources when deleting or updating a
`ReplicationController` in your configuration.

## Kong Enterprise Edition

Kong Enterprise is our powerful offering for larger organizations in need of security, monitoring, 
compliance, developer onboarding, higher performance, granular access and a dashboard to manage 
Kong easily. Learn more at https://konghq.com/kong-enterprise-edition/.

[kong-logo]: https://konghq.com/wp-content/uploads/2017/10/kong-cover@2x-1.png
[website-url]: https://konghq.com/
[website-badge]: https://img.shields.io/badge/GETKong.org-Learn%20More-43bf58.svg
[documentation-url]: https://getkong.org/docs/
[documentation-badge]: https://img.shields.io/badge/Documentation-Read%20Online-green.svg
[discussion-badge]: https://img.shields.io/badge/Discuss-Join%20Kong%20Nation-blue.svg
[discussion-url]: https://discuss.konghq.com/

