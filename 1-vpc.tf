resource "aws_vpc" "k8s" {
  cidr_block = "${var.cidr_vpc}"
  tags = {
    Name = "${var.vpc_name}"
  }
}