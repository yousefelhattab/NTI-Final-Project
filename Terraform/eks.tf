resource "aws_eks_cluster" "project" {
  name     = "${var.environment}-${var.cluster_name}"
  role_arn = aws_iam_role.eks_worker_role.arn

  vpc_config {
    subnet_ids = aws_subnet.project[*].id
  }

  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly
  ]
}

resource "aws_eks_node_group" "project" {
  cluster_name    = aws_eks_cluster.project.name
  node_group_name = "${var.environment}-worker-group"
  node_role_arn   = aws_iam_role.eks_node_role.arn
  subnet_ids      = aws_subnet.project[*].id

  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }

  instance_types = ["t3.micro"]  # Use an alternative instance type
  update_config {
    max_unavailable = 1
  }

  tags = {
    "Name" = "project-node-group"
  }

  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly
  ]

}