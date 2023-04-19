module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.10.0"

  cluster_name    = "${lower(var.project)}${lower(var.stage)}k8s"
  cluster_version = var.k8s_version

  iam_role_use_name_prefix = false
  iam_role_name            = "${lower(var.project)}${lower(var.stage)}iamroleeks"

  vpc_id                         = var.vpc_id
  subnet_ids                     = var.subnet_ids
  cluster_endpoint_public_access = true

  eks_managed_node_groups = {
    for group in var.nodegroups : group.suffix => {
      name           = "${lower(var.project)}${lower(var.stage)}k8snodegroup${group.suffix}"
      iam_role_name  = "${lower(var.project)}${lower(var.stage)}iamrolenodegroup${group.suffix}"
      instance_types = [group.instance_type]

      min_size     = group.scaling.min
      desired_size = group.scaling.desired
      max_size     = group.scaling.max
      disk_size    = group.disk_size
      subnet_ids   = group.subnet_ids
    }
  }

  manage_aws_auth_configmap = true

  aws_auth_roles = var.aws-auth-map-roles
}

data "aws_eks_cluster_auth" "k8s" {
  name = module.eks.cluster_name
}

provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  token                  = data.aws_eks_cluster_auth.k8s.token
}

