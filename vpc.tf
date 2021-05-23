# For VPC
resource "aws_vpc" "prasanna-vpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  enable_classiclink   = "false"
  tags = {
    Name = "prasanna-main"
  }
}

# For Subnets
resource "aws_subnet" "prasanna-public" {
  vpc_id                  = aws_vpc.prasanna-vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-east-2a"
  tags = {
    Name = "prasanna-public"
  }
}


resource "aws_subnet" "prasanna-private-1" {
  vpc_id                  = aws_vpc.prasanna-vpc.id
  cidr_block              = "10.0.4.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-east-2a"
  tags = {
    Name = "prasanna-private-1"
  }
}

resource "aws_subnet" "prasanna-private-2" {
  vpc_id                  = aws_vpc.prasanna-vpc.id
  cidr_block              = "10.0.5.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-east-2b"
  tags = {
    Name = "prasanna-private-2"
  }
}

# For Internet Gateway
resource "aws_internet_gateway" "prasanna-gw" {
  vpc_id = aws_vpc.prasanna-vpc.id
  tags = {
    Name = "prasanna-gw"
  }
}

# For Route Tables
resource "aws_route_table" "prasanna-public-rt" {
  vpc_id = aws_vpc.prasanna-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.prasanna-gw.id
  }
  tags = {
    Name = "prasanna-public-rt"
  }
}

# For Route associations public
resource "aws_route_table_association" "prasanna-public-rt-1" {
  subnet_id      = aws_subnet.prasanna-public.id
  route_table_id = aws_route_table.prasanna-public-rt.id
}
