resource "aws_autoscaling_group" "my-asg" {
    launch_template {
      id = aws_launch_template.my-vpc-lt.id
      version = "$Latest"
    }
    vpc_zone_identifier = [ aws_subnet.my-vpc-private-sub.id ]
    min_size = 1
    max_size = 3
    desired_capacity = 2
  
}