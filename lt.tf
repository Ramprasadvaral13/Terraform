resource "aws_launch_template" "my-vpc-lt" {
    image_id = var.ami
    instance_type = var.instance
    key_name = aws_key_pair.Tf-keypair.key_name

    network_interfaces {
      subnet_id = aws_subnet.my-vpc-private-sub.id
      security_groups = [ aws_security_group.lt-sg.id ]
      associate_public_ip_address = false
    }
  
}
