resource "aws_key_pair" "Tf-keypair" {
    key_name = var.key-name
    public_key = file("/Users/ramprasad/.ssh/id_rsa.pub")
  
}

resource "aws_instance" "my-instance" {
    instance_type = var.instance
    ami = var.ami
    key_name = aws_key_pair.Tf-keypair.key_name
    subnet_id = aws_subnet.my-vpc-public-sub.id
    security_groups = [ aws_security_group.my-sg.id ]

    provisioner "remote-exec" {
        inline = [ "sudo apt update" ]
        connection {
          type = "ssh"
          host = self.public_ip
          private_key = file("/Users/ramprasad/.ssh/id_rsa")
          user = "ubuntu"
        }
      
    }
  
}