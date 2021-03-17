# Eth2-k8s

This project deploys a fully featured, best practices Eth2 validator setup on Google Kubernetes Engine.

Brought to you by MIDL.dev
--------------------------

<img src="midl-dev-logo.png" alt="MIDL.dev" height="100"/>

We help you deploy and manage a complete Eth2 validator infrastructure for you. [Hire us](https://midl.dev).

Architecture
------------

This is a Kubernetes private cluster with two nodes located in two Google Cloud zones, in the same region.

The validator node uses a [Regional Persistent Disk](https://cloud.google.com/compute/docs/disks/#repds) so it can be respun quickly in the other node from the pool if the first node goes offline for any reason, for example base OS upgrade.

The setup is production hardened:
* usage of kubernetes secrets to store sensitive values such as node keys. They are created securely from terraform variables,
* network policies to restrict communication between pods. For example, only sentries can peer with the validator node.

## Costs

Deploying will incur Google Compute Engine charges, specifically:

* virtual machines
* regional persistent SSD storage
* network ingress
* NAT forwarding

# How to deploy

*WARNING: Eth2 tokens have value. Use judgement and care in your network interactions, otherwise loss of funds may occur.*

## Prerequisites

1. Download and install [Terraform](https://terraform.io)

1. Download, install, and configure the [Google Cloud SDK](https://cloud.google.com/sdk/).

1. Install the [kubernetes
   CLI](https://kubernetes.io/docs/tasks/tools/install-kubectl/) (aka
   `kubectl`)

## Authentication

Using your Google account, active your Google Cloud access.

Login to gcloud using `gcloud auth login`

Set up [Google Default Application Credentials](https://cloud.google.com/docs/authentication/production) by issuing the command:

```
gcloud auth application-default login
```

NOTE: for production deployments, the method above is not recommended. Instead, you should use a Terraform service account following [these instructions](docs/production-hardening.md).

## Populate terraform variables

All custom values unique to your deployment are set as terraform variables. You must populate these variables manually before deploying the setup.

A simple way is to populate a file called `terraform.tfvars` in the `terraform` folder.

NOTE: `terraform.tfvars` is not recommended for a production deployment. See [production hardening](docs/production-hardening.md).

## Deploy!

1. Run the following:

```
cd terraform

terraform init
terraform plan -out plan.out
terraform apply plan.out
```

This will take time as it will:
* create a Kubernetes cluster
* build the necessary containers
* download and unzip the archives if applicable
* spin up the sentry and validator nodes
* sync the network


## Wrapping up

To delete everything and terminate all the charges, issue the command:

```
terraform destroy
```

Alternatively, go to the GCP console and delete the project.
