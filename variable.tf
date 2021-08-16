# Let's create variables for our resources in main.tf to make use of DRY

variable "aws_key_name" {
	
default = "eng89_saim"

}

variable "aws_key_path" {
	
default = "~/.ssh/eng89_saim.pem"
}