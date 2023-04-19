# AWS kubernetes resources

## Introduction

This module manages required AWS Kubernetes resources as EKS clusters.

Uses [terraform-aws-modules/eks/aws](https://registry.terraform.io/modules/terraform-aws-modules/eks/aws) for implementation.

## Usage

Instantiate the module by calling it from Terraform like this:

```hcl
module "aws-eks" {
  source = "dodevops/kubernetes/aws"
  version = "<version>"
  
  (...)
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

The following requirements are needed by this module:

- kubernetes (>=2.19.0)

## Providers

The following providers are used by this module:

- aws

## Modules

The following Modules are called:

### eks

Source: terraform-aws-modules/eks/aws

Version: 19.10.0

## Resources

The following resources are used by this module:

- [aws_eks_cluster_auth.k8s](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster_auth) (data source)

## Required Inputs

The following input variables are required:

### aws-auth-map-roles

Description: Desired content of the [aws-auth configmap](https://docs.aws.amazon.com/eks/latest/userguide/add-user-role.html)

Type: `list(any)`

### k8s\_version

Description: [Kubernetes version](https://docs.aws.amazon.com/eks/latest/userguide/kubernetes-versions.html) to use for the EKS cluster.

Type: `string`

### nodegroups

Description: List of Nodegroup configurations

* suffix: Nodegroup name suffix
* subnet\_ids: Ids of used subnets in the nodegroup
* scaling: Scaling configuration
  * desired: Desired number of nodes
  * min: Minimum number of nodes
  * max: Maximum number of nodes
* disk\_size: Disk size in GB
* instance\_type: Instance type of the nodes}

Type:

```hcl
list(object({
    suffix : string,
    subnet_ids : list(string),
    scaling : object({
      min : number,
      max : number,
      desired : number
    }),
    disk_size : number,
    instance_type : string
  }))
```

### project

Description: Project this configuration is for

Type: `any`

### stage

Description: Name of the stage for this state

Type: `string`

### subnet\_cidrs

Description: List of IDs of subnets to use in the EKS

Type: `list(string)`

### subnet\_ids

Description: List of IDs of subnets to use in the EKS

Type: `list(string)`

### vpc\_id

Description: ID of the VPC the cluster is in

Type: `string`

## Optional Inputs

No optional inputs.

## Outputs

The following outputs are exported:

### ca\_certificate

Description: CA certificate of the EKS endpoint

### host

Description: EKS cluster endpoint

### oidc\_provider

Description: OIDC provider used by the EKS

### token

Description: Auth token for the EKS endpoint
<!-- END_TF_DOCS -->

## Development

Use [terraform-docs](https://terraform-docs.io/) to generate the API documentation by running

    terraform fmt .
    terraform-docs .
