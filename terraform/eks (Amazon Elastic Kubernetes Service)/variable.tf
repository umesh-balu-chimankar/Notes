variable "region" {
  description = "AWS region"
  type        = string
  default     = "eu-west-3"
}

variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
  default     = "my-eks-cluster"
}

variable "eks_role_name" {
  description = "IAM role name for EKS cluster"
  type        = string
  default     = "eks-cluster-role"
}

variable "subnet_ids" {
  description = "Subnets for EKS cluster"
  type        = list(string)
  default = [
    "subnet-02eeb5247c4007027",
    "subnet-0a841430fdfb696f4",
    "subnet-03c1446940d7891fe"
  ]
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}
