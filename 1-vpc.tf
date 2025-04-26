# Creating of VPC in AWS called cloud-vpc
#========================================
resource "aws_vpc" "cloud-vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "cloud-vpc"
  }
}


# Creating of public subnet 01
#========================================
resource "aws_subnet" "public-subnet01" {
  vpc_id     = aws_vpc.cloud-vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "public-subnet01"
  }
}


# Creating of Public Subnet 02
#========================================
resource "aws_subnet" "public-subnet02" {
  vpc_id     = aws_vpc.cloud-vpc.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "public-subnet02"
  }
}


# Creating of internet gateway
#==============================
resource "aws_internet_gateway" "i-g-w" {
  vpc_id = aws_vpc.cloud-vpc.id
  


  tags = {
    Name = "Internet-gateway"
  }
}

# Creating the Route table
resource "aws_route_table" "route-table" {
  vpc_id = aws_vpc.cloud-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.i-g-w.id
  }

  tags = {
    Name = "route-table"
  }
}

# Creating Route associate for the two subnets
#subnet one.
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.public-subnet01.id
  route_table_id = aws_route_table.route-table.id
}

# subnet two
resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.public-subnet02.id
  route_table_id = aws_route_table.route-table.id
}


