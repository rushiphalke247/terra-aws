terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
provider "aws" {
  region = var.region
}


resource "aws_instance" "java_app" {
  ami = var.ami_id
  instance_type = var.instance_type
  user_data = file("script.sh")
  tags = {
    Name = "Devops-app"
  }
}

resource "aws_security_group" "allow_web" {
  name  =  "allow_web_ssh"

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 80
    to_port   = 80 
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port   = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

