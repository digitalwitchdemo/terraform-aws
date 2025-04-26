resource "aws_network_acl" "main" {
  vpc_id = aws_vpc.cloud-vpc.id

# Egress Rule - Allow ALL traffic
  egress {
    protocol   = "-1"             # -1 means all protocols
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"      # to anywhere
    from_port  = 0
    to_port    = 0
  }
 # Ingress: allow HTTP (port 80)
  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "10.3.0.0/18"
    from_port  = 80
    to_port    = 80
  }

  # Ingress: allow SSH (port 22)
  ingress {
    protocol   = "tcp"
    rule_no    = 110
    action     = "allow"
    cidr_block = "0.0.0.0/0"  # or restrict to your IP/CIDR
    from_port  = 22
    to_port    = 22
  }

  tags = {
    Name = "network access control list"
  }
}

resource "aws_network_acl_association" "main1" {
  network_acl_id = aws_network_acl.main.id
  subnet_id      = aws_subnet.public-subnet01.id
}

resource "aws_network_acl_association" "main2" {
  network_acl_id = aws_network_acl.main.id
  subnet_id      = aws_subnet.public-subnet02.id
}