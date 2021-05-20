resource "aws_security_group" "k8s-nodes-sg" {
  name        = "${var.sg_name}"
  description = "Allow SSH forom anywhere, allow tcp 80"
  vpc_id      = aws_vpc.k8s.id

  ingress {
    description      = "allow ssh"
    from_port        = 0
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  
  ingress {
    description      = "allow tcp 80"
    from_port        = 0
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

    ingress {
    description      = "allow tcp 8080"
    from_port        = 0
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.sg_name}"
  }
}
