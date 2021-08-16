# Terraform
## What is Terraform?
Terraform is a tool for building, changing, and versioning infrastructure safely and efficiently. Terraform can manage existing and popular service providers as well as custom in-house solutions. Configuration files describe to Terraform the components needed to run a single application or your entire datacenter.

## Benefits
- Terraform modules are useful because they allow complex resources to be automated with re-usable, configurable constructs.
- Cloud independent - works with different cloud providers, allowing for multi-cloud configuration
- Can effectively scale up/down to meet the current load.
- Reduced time to provision and reduced development costs.
- Ease of use.
- Simplicity, it does a lot of work for us behind, in the background.

## Installation
- Download Terraform for the applicable platform here: https://www.terraform.io/downloads.html
- Extract and place the terraform file in a file location of your choice.
- In Search, type and select Edit the system environment variables.
- Click Environment Variables...
- Edit the Path variable in User variables.
- Click New, then add the file path of the terraform file inside

## Commands 
- `terraform init`: initialises the terraform with required dependencies of the provider mentioned in the main.tf.
- `terraform plan`: checks the syntax of the code. Lists the jobs to be done (in main.tf).
- `terraform apply`: launches and executes the tasks in main.tf
- `terraform destroy`: destroys/terminates services run in main.tf

## Creating an EC2 Instance from an AMI
- Specify some details about the instance
- To SSH into the instance you need to specify the SSH key name. 
```
provider "aws"{
	region = "eu-west-1"
}

resource "aws_instance" "app_instance"{
	ami = "ami-038d7b856fe7557b3"

	instance_type = "t2.micro"

	associate_public_ip_address = true

	key_name = "eng89_saim"

	tags = {
		Name = "eng89_saim_terraform"
	}
}
```