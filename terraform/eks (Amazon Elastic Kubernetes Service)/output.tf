output "eks_cluster_name" {
  description = "EKS cluster name"
  value       = aws_eks_cluster.eks_cluster.name
}

output "eks_cluster_endpoint" {
  description = "EKS API server endpoint"
  value       = aws_eks_cluster.eks_cluster.endpoint
}

output "eks_cluster_arn" {
  description = "EKS cluster ARN"
  value       = aws_eks_cluster.eks_cluster.arn
}

output "eks_cluster_role_arn" {
  description = "IAM role ARN used by EKS"
  value       = aws_iam_role.eks_cluster_role.arn
}
