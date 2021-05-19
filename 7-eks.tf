resource "aws_eks_cluster" "eks_k8s" {
  name     = "${var.eks_name}"
  role_arn = aws_iam_role.cluser-role.arn
  
  vpc_config {
    endpoint_public_access = true
    subnet_ids             = [aws_subnet.sub1-k8s.id, aws_subnet.sub2-k8s.id]
    security_group_ids     = [aws_security_group.k8s-nodes-sg.id] 
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSClusterPolicy-attach,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly-attach,
    aws_iam_role_policy_attachment.CloudWatchAgentServerPolicy-attach,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy-attach
  ]
}