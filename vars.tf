variable "project" {
  description = "Project this configuration is for"
}

variable "stage" {
  type        = string
  description = "Name of the stage for this state"
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of IDs of subnets to use in the EKS"
}

variable "subnet_cidrs" {
  type        = list(string)
  description = "List of IDs of subnets to use in the EKS"
}

variable "vpc_id" {
  type        = string
  description = "ID of the VPC the cluster is in"
}

variable "k8s_version" {
  type        = string
  description = "[Kubernetes version](https://docs.aws.amazon.com/eks/latest/userguide/kubernetes-versions.html) to use for the EKS cluster."
}

variable "nodegroups" {
  type = list(object({
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
  description = <<EOL
List of Nodegroup configurations

* suffix: Nodegroup name suffix
* subnet_ids: Ids of used subnets in the nodegroup
* scaling: Scaling configuration
  * desired: Desired number of nodes
  * min: Minimum number of nodes
  * max: Maximum number of nodes
* disk_size: Disk size in GB
* instance_type: Instance type of the nodes}
EOL
}

variable "aws-auth-map-roles" {
  type        = list(any)
  description = "Desired content of the [aws-auth configmap](https://docs.aws.amazon.com/eks/latest/userguide/add-user-role.html)"
}
