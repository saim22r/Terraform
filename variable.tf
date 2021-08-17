# Let's create variables for our resources in main.tf to make use of DRY

variable "aws_key_name" {
	default = "eng89_saim"

}

variable "aws_key_path" {
	default = "~/.ssh/eng89_saim.pem"
}

variable "my_ip" {
	default = "80.3.207.165/32"
}