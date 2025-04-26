# Creating A security Group
#==========================
resource "aws_security_group" "sec-group" {
  name        = "allow_in-and-out"
  description = "Allow TLS inbound traffic and all outbound traffic and some inbound"
  vpc_id      = aws_vpc.cloud-vpc.id

  tags = {
    Name = "cloud-sec-group-01"
  }
}



# Create rule to allow all outbound (egress)
#=============================================
resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.sec-group.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" 
}

#Creating rule to allow only port 22 
resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.sec-group.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}
