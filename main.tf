# Lets build a script to connect AWS and download/setup all dependencies required
# keyword: provider aws


 provider "aws" {

        region = "eu-west-1"
}


# then we will run terraform init

# then we will move on to launch aws services

# Lets launch an ec2 in eu-west-1 with AMI

# keyword called "resource" provide resource name and give name with specific details to the service

resource "aws_instance" "app_instance" {

# resource aws_ec2_instance, name it as eng89_saim_terraform, ami, type of instance, with or without ip,

ami = "ami-038d7b856fe7557b3"
instance_type = "t2.micro"
associate_public_ip_address = true
key_name = "eng89_saim"

# tags is the key word to name the instance eng89_saim_terraform
tags = {
Name = "eng89_saim_terraform"


 }
}

# Common commands
# terraform plan checks the syntax and validates the instruction we have provided in this script

# once we are happy and the outcome in green we can run terraform apply