output "host" {
  description = "EKS cluster endpoint"
  value       = module.eks.cluster_endpoint
}

output "ca_certificate" {
  description = "CA certificate of the EKS endpoint"
  value       = base64decode(module.eks.cluster_certificate_authority_data)
}

output "token" {
  description = "Auth token for the EKS endpoint"
  sensitive   = true
  value       = data.aws_eks_cluster_auth.k8s.token
}

output "oidc_provider" {
  description = "OIDC provider used by the EKS"
  value       = module.eks.oidc_provider
}