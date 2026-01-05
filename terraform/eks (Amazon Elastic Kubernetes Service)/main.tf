provider "aws" {
  region = var.region
}

# -----------------------------
# IAM Role for EKS Cluster
# -----------------------------
resource "aws_iam_role" "eks_cluster_role" {
  name = var.eks_role_name

  assume_role_policy = data.aws_iam_policy_document.eks_assume_role.json
}

# Attach required AWS managed policies
resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_cluster_role.name
}

resource "aws_iam_role_policy_attachment" "eks_vpc_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.eks_cluster_role.name
}

# Trust policy for EKS
data "aws_iam_policy_document" "eks_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

# -----------------------------
# EKS Cluster
# -----------------------------
resource "aws_eks_cluster" "eks_cluster" {
  name     = var.cluster_name
  role_arn = aws_iam_role.eks_cluster_role.arn

  vpc_config {
    subnet_ids = var.subnet_ids
  }

  enabled_cluster_log_types = [
    "api",
    "audit",
    "authenticator"
  ]

  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_policy,
    aws_iam_role_policy_attachment.eks_vpc_policy
  ]

  tags = {
    Name        = var.cluster_name
    Environment = var.environment
  }
}
