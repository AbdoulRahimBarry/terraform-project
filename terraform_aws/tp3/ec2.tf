provider "aws" {
  region     = "${var.my_region}"
  access_key = "${var.my_acces_key}"
  secret_key = "${var.my_secret_key}"
}

data "aws_ami" "mydata" {
  most_recent = true
  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*"]
  }

}

resource "aws_instance" "myec2" {
  ami           = data.aws_ami.mydata.id
  instance_type = "${var.myinstance}"
  key_name = "devops-abdoul"

  security_groups = ["${aws_security_group.allow_traffic.name}"]

  tags = var.mytag
  
  root_block_device {
    delete_on_termination = true
 }
}

resource "aws_eip" "lb" {
  instance = aws_instance.myec2.id
  vpc      = true
}

resource "aws_security_group" "allow_traffic" {
  name        = "allow_paquet"
  description = "Allow http and https inbound traffic"

  ingress {
    description = "https from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "http from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }  

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
