
resource "aws_key_pair" "generated_key" {
  key_name   = "mykey1"
  public_key = tls_private_key.rsa-4096-mykey.public_key_openssh
}

resource "aws_instance" "ec2-inst" {
  ami           = "ami-084568db4383264d4"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public-subnet01.id
  key_name = aws_key_pair.generated_key.key_name
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.sec-group.id]

  tags = {
    Name = "webserver-01"
  }
}

