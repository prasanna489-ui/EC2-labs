resource "null_resource" "copy_execute2" {

    connection {
    type = "ssh"
    host = aws_instance.prasanna-ec2.public_ip
    user = "ubuntu"
    private_key = file("prasanna-key")
    }


  provisioner "file" {
    source      = "ansible.sh"
    destination = "/tmp/ansible.sh"
  }

   provisioner "file" {
    source      = "moodle.conf"
    destination = "/tmp/moodle.conf"
  }

   provisioner "file" {
    source      = "moodle.yaml"
    destination = "/tmp/moodle.yaml"
  }

   provisioner "remote-exec" {
    inline = [
      "sudo chmod 777 /tmp/ansible.sh",
      "sh /tmp/ansible.sh",
    ]
  }
