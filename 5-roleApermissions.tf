# data "aws_eks_cluster" "example" {
#   name = "example"
# }

#-------------- this role for k8s cluster --------------------------------------------------
resource "aws_iam_role" "cluser-role" {
  name = "eks-cluster-role"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}
#---------------- this to create role for ec2 nodes --------------------------------------
resource "aws_iam_role" "k8s-ec2" {
  name = "eks-node-group-example"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

#-------------- adding permissions to cluster k8s ----------------------------------------

resource "aws_iam_role_policy_attachment" "AmazonEKSClusterPolicy-attach" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.cluser-role.name
}

resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly-attach" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.cluser-role.name
}

resource "aws_iam_role_policy_attachment" "CloudWatchAgentServerPolicy-attach" {
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
  role       = aws_iam_role.cluser-role.name
}

resource "aws_iam_role_policy_attachment" "AmazonEKS_CNI_Policy-attach" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.k8s-ec2.name
}

#--------------- adding permissions to ex2 role of k8s cluster ------------------------------

resource "aws_iam_role_policy_attachment" "AmazonEKSClusterPolicy-ec2" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.k8s-ec.name
}

resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly-ec2" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.k8s-ec2.name
}

resource "aws_iam_role_policy_attachment" "CloudWatchAgentServerPolicy-ec2" {
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
  role       = aws_iam_role.k8s-ec2.name
}

resource "aws_iam_role_policy_attachment" "AmazonEKS_CNI_Policy-ec2" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.k8s-ec2.name
}