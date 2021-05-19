resource "tls_private_key" "pk" {
  algorithm = "RSA"
  rsa_bits  = 4096    

  provisioner "local-exec" {
    command = "echo '${self.private_key_pem}' > ./myKey.pem"
  }
}

resource "aws_key_pair" "kp" { 
  key_name   = "ansible-k8s"
  public_key = tls_private_key.pk.public_key_openssh
}
