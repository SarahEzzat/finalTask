resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.k8s.id

  tags = {
    Name = "${var.igw_name}"
  }
}