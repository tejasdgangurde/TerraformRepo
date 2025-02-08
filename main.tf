terraform {
  required_version = "~> 1.1"
  required_providers {
    aws = {
      version = "~>3.1"
    }
  }
}
provider "aws" {
  region = var.my_region
  access_key = var.access_key
  secret_key = var.secret_key
}
resource "aws_instance" "myec2" {
  ami           = var.my_ami
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.mysg.id]
  tags = {
    Name = "myinstance"
  }
  key_name = "mytf-key"
provisioner "local-exec" {
   command = "echo ${aws_instance.myec2.public_ip} > ip.txt"
}
}
variable "my_region" {
  type = string
  default = "ap-south-1"
  }
  variable "access_key" {  }
  variable "secret_key" {  }
variable "my_ami" { 
type = string
default = "ami-00bb6a80f01f03502"
}
