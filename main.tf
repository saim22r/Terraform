
 provider "aws" {

        region = "eu-west-1"
}

resource "aws_instance" "app_instance" {
ami = "ami-038d7b856fe7557b3"
instance_type = "t2.micro"
associate_public_ip_address = true
key_name = var.aws_key_name

tags = {
Name = "eng89_saim_terraform"
 }
}
