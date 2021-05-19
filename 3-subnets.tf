#--------------- need two subnets with two diff ava zones for high ava.
resource "aws_subnet" "sub1-k8s" {
  vpc_id     = aws_vpc.k8s.id
  availability_zone = "us-east-1b"
  cidr_block = "${var.sub1_cidr}"
  tags = {
        Name = "${var.sub1_name}"
    }
}

resource "aws_subnet" "sub2-k8s" {
  vpc_id     = aws_vpc.k8s.id
  availability_zone = "us-east-1c"
  cidr_block = "${var.sub2_cidr}"
   tags = {
        Name = "${var.sub2_name}"
    }
}
