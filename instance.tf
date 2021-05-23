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

provisioner "remote-exec" {
  inline = ["echo 'build ssh connection' >> /tmp/file "]
  connection {
	host = self.public_ip
	type = "ssh"
	user = "ubuntu"
	private_key = file("./prasanna-key")

 }
}
provisioner "local-exec" {
	command = "ansible-playbook -i ${aws_instance.prasanna-ec2.public_ip}, --private-key ${var.PATH_TO_PRIVATE_KEY} provisioner.yaml -b"
 }

}
