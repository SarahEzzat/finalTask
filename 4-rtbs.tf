resource "aws_route_table" "rtb_pub" {
  vpc_id = aws_vpc.k8s.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.k8s_igw.id
  }

  tags = {
    Name = "${var.rtb_name}"
  }
}

#---------------- this is assosiation of subnets to routetables

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.sub1-k8s.id
  route_table_id = aws_route_table.rtb_pub.id
}


resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.sub2-k8s.id
  route_table_id = aws_route_table.rtb_pub.id
}