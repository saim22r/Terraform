
 provider "aws" {
        region = "eu-west-1"
}

# Create a VPC
resource "aws_vpc" "terraform_vpc_code_test" {
  cidr_block       = "10.203.0.0/16"
  instance_tenancy = "default"

tags = {
  Name = "eng89_saim_terraform_vpc"
 }
}

# Create Internet Gateway
resource "aws_internet_gateway" "terraform_igw" {
  vpc_id = aws_vpc.terraform_vpc_code_test.id
  
tags = {
  Name = "eng89_saim_terraform_IG"
 }
}

# Create a route table


# Launch an instance
resource "aws_instance" "app_instance" {
  ami = "ami-038d7b856fe7557b3"
  instance_type = "t2.micro"
  associate_public_ip_address = true
  key_name = var.aws_key_name

tags = {
  Name = "eng89_saim_terraform_app"
 }
}