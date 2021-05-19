# data "aws_eks_cluster" "example" {
#   name = "example"
# }


resource "aws_iam_role" "cluser-role" {
  name = "eks-cluster-role"

  assume_role_policy = <<POLICY
{
  "Version": "",
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

#-------------- adding permissions

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
  role       = aws_iam_role.cluser-role.name
}