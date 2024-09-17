resource "aws_vpc" "my-vpc" {
    cidr_block = var.cidr
    enable_dns_hostnames = true
    enable_dns_support = true
  
}

resource "aws_internet_gateway" "my-vpc-igw" {
    vpc_id = aws_vpc.my-vpc.id
  
}

resource "aws_subnet" "my-vpc-public-sub" {
    vpc_id = aws_vpc.my-vpc.id
    cidr_block = var.public-subnet
    availability_zone = var.Az
    map_public_ip_on_launch = true
}

resource "aws_subnet" "my-vpc-private-sub" {
    vpc_id = aws_vpc.my-vpc.id
    availability_zone = var.Az
    cidr_block = var.private-subnet
  
}

resource "aws_route_table" "my-vpc-public-route" {
    vpc_id = aws_vpc.my-vpc.id
    route {
        gateway_id = aws_internet_gateway.my-vpc-igw.id
        cidr_block = var.route-cidr
    }
  
}

resource "aws_route_table_association" "my-vpc-public-rtba" {
    route_table_id = aws_route_table.my-vpc-public-route.id
    subnet_id = aws_subnet.my-vpc-public-sub.id
  
}

resource "aws_eip" "my-aws-eip" {
    domain = "vpc"
  
}

resource "aws_nat_gateway" "my-vpc-nat" {
    allocation_id = aws_eip.my-aws-eip.id
    subnet_id = aws_subnet.my-vpc-public-sub.id
  
}

resource "aws_route_table" "my-vpc-private-route" {
    vpc_id = aws_vpc.my-vpc.id
    route {
        cidr_block = var.route-cidr
        nat_gateway_id = aws_nat_gateway.my-vpc-nat.id
    }
  
}

resource "aws_route_table_association" "my-vpc-private-rtba" {
    route_table_id = aws_route_table.my-vpc-private-route.id
    subnet_id = aws_subnet.my-vpc-private-sub.id
  
}