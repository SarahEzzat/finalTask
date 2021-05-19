resource "aws_eks_node_group" "k8s-ng" {
  cluster_name    = aws_eks_cluster.eks_k8s.name
  node_group_name = "${var.ng-name}"
  node_role_arn   = aws_iam_role.k8s-ec2.arn
  subnet_ids      = [aws_subnet.sub1-k8s.id,aws_subnet.sub2-k8s.id]
  ami_type        = "${var.ami_type}"
  capacity_type   = "${var.capacity}"
  instance_types  = ["${var.ins_type}"]
  remote_access {
    ec2_ssh_key     = aws_key_pair.kp.key_name   
  }
 
  scaling_config {
    desired_size = "${var.desired-n}"
    max_size     = "${var.max-n}"
    min_size     = "${var.min-n}"
  }
  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy-ec2,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy-ec2,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly-ec2,
    aws_iam_role_policy_attachment.CloudWatchAgentServerPolicy-ec2
  ]
  
}
