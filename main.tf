# Set provider and region
 provider "aws" {
        region = "eu-west-1"
}

# Create a VPC
resource "aws_vpc" "terraform_vpc" {
  cidr_block       = "10.203.0.0/16"
  instance_tenancy = "default"

tags = {
  Name = "eng89_saim_terraform_vpc"
 }
}

# Create Internet Gateway
resource "aws_internet_gateway" "terraform_igw" {
  vpc_id = aws_vpc.terraform_vpc.id
  
tags = {
  Name = "eng89_saim_terraform_IG"
 }
}

# Create a route table
resource "aws_route_table" "saim_RT" {
    vpc_id = aws_vpc.terraform_vpc.id
    route {
        cidr_block = "0.0.0.0/0" 
        gateway_id = aws_internet_gateway.terraform_igw.id
    }
    
tags = {
  Name = "eng89_saim_terraform_RT"
 }
}

# Create public subnet
resource "aws_subnet" "saim_public_subnet" {
    vpc_id = aws_vpc.terraform_vpc.id
    cidr_block = "10.203.1.0/24"
    map_public_ip_on_launch = "true" 
    availability_zone = "eu-west-1a"
    tags = {
        Name = "eng89_saim_subnet_public"
    }
}

# Associate route tables with the subnet
resource "aws_route_table_association" "saim_public_subnet"{
    subnet_id = aws_subnet.saim_public_subnet.id
    route_table_id = aws_route_table.saim_RT.id
}

# Add Network ACL rules
resource "aws_network_acl" "saim_NACL" {
   vpc_id = aws_vpc.terraform_vpc.id
   subnet_ids = [aws_subnet.saim_public_subnet.id]

  ingress {
    protocol = "tcp"
    rule_no = 100
    action = "allow"
    cidr_block = "0.0.0.0/0"
    from_port = 80
    to_port = 80
  }

  ingress {
    protocol = "tcp"
    rule_no = 110
    action = "allow"
    cidr_block = var.my_ip
    from_port = 22
    to_port = 22
  }

  ingress {
    protocol = "tcp"
    rule_no = 120
    action = "allow"
    cidr_block = "0.0.0.0/0"
    from_port = 1024
    to_port = 65535
  }

  egress {
    protocol = "tcp"
    rule_no = 100
    action = "allow"
    cidr_block = "0.0.0.0/0"
    from_port = 80
    to_port = 80
  }

  egress {
    protocol = "tcp"
    rule_no = 110
    action = "allow"
    cidr_block = "10.203.2.0/24"
    from_port = 27017
    to_port = 27017
  }

  egress {
    protocol = "tcp"
    rule_no = 120
    action = "allow"
    cidr_block = "0.0.0.0/0"
    from_port = 1024
    to_port = 65535
  }
}

# Add Security group rules
resource "aws_security_group" "saim_SG" {
  vpc_id = aws_vpc.terraform_vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "eng89_saim_sg_app"
  }
}

# Launch an instance
resource "aws_instance" "app_instance" {
  ami = "ami-038d7b856fe7557b3"
  subnet_id = aws_subnet.saim_public_subnet.id
  instance_type = "t2.micro"
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.saim_SG.id]
  key_name = var.aws_key_name

tags = {
  Name = "eng89_saim_terraform_app"
 }
}