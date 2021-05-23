resource "aws_instance" "prasanna-ec2" {
  ami           = var.AMIS[var.AWS_REGION]
  instance_type = "t2.micro"
  
# the VPC subnet
  subnet_id = aws_subnet.prasanna-public.id
  
# the security group
  vpc_security_group_ids = [aws_security_group.allow-ssh.id]
  
# the public SSH key
  key_name = aws_key_pair.prasanna-key.key_name
  tags = {
	Name = "prasanna-ansible"
  }

