# For NAT Gateway
resource "aws_eip" "prasanna-nat" {
  vpc = true
}

resource "aws_nat_gateway" "prasanna-nat-gw" {
  allocation_id = aws_eip.prasanna-nat.id
  subnet_id     = aws_subnet.prasanna-public.id
  depends_on    = [aws_internet_gateway.prasanna-gw]
  tags = {
	Name = "prasanna-nat"
 }
}

# For Route Table
resource "aws_route_table" "prasanna-private" {
  vpc_id = aws_vpc.prasanna-vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.prasanna-nat-gw.id
  }
  tags = {
    Name = "prasanna-private"
  }
}

# For Route associations private
resource "aws_route_table_association" "prasanna-private-1-a" {
  subnet_id      = aws_subnet.prasanna-private-1.id
  route_table_id = aws_route_table.prasanna-private.id
}

resource "aws_route_table_association" "prasanna-private-1-b" {
  subnet_id      = aws_subnet.prasanna-private-2.id
  route_table_id = aws_route_table.prasanna-private.id
}
