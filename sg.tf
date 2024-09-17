resource "aws_security_group" "my-sg" {
    vpc_id = aws_vpc.my-vpc.id
    name = "tf-sg"
    description = "tf-sg"

    ingress {
        protocol = "tcp"
        from_port = 22
        to_port = 22
        cidr_blocks = [ "0.0.0.0/0" ]
    }

    egress {
        protocol = "-1"
        from_port = 0
        to_port = 0
        cidr_blocks = [ "0.0.0.0/0" ]
    }
  
}

resource "aws_security_group" "lt-sg" {
    vpc_id = aws_vpc.my-vpc.id
    name = "lt-sg"
    description = "lt-sg"

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    }

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    }

    egress {
        protocol = "-1"
        from_port = 0
        to_port = 0
        cidr_blocks = [ "0.0.0.0/0" ]
    }
  
}