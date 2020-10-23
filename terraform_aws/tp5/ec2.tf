provider "aws" {
  region     = "${var.my_region}"
  access_key = "${var.my_acces_key}"
  secret_key = "${var.my_secret_key}"
}

terraform {
  backend "s3" {
    bucket = "terraform-backend-abdoul"
    key    = "abdoul.tfstate"
    region = "us-east-1"
    access_key = "YOU ACCES KEY"
    secret_key = "YOU SECRET KEY"
  }
}

data "aws_ami" "mydata" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*"]
  }

}

resource "aws_instance" "myec2" {
  ami           = data.aws_ami.mydata.id
  instance_type = "${var.myinstance}"
  key_name      = "devops-abdoul"

  security_groups = ["${aws_security_group.allow_traffic.name}"]

  tags = var.mytag

  root_block_device {
    delete_on_termination = true
  }

  provisioner "remote-exec" {
    inline = [
      "sudo amazon-linux-extras install -y nginx1.12",
      "sudo systemctl start nginx"
    ]
    connection {
      type     = "ssh"
      user     = "ec2-user"
      private_key = file("./devops-abdoul.pem")
      host     = self.public_ip
      timeout     = "1m"
    }
  }

}

resource "aws_security_group" "allow_traffic" {
  name        = "allow_paquet_3"
  description = "Allow ssh, http and https inbound traffic"

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

  ingress {
    description = "ssh from VPC"
    from_port   = 22
    to_port     = 22
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

resource "aws_eip" "lb" {
  instance = aws_instance.myec2.id
  vpc      = true

  provisioner "local-exec" {
    command = "echo PUBLIC IP: ${aws_eip.lb.public_ip} ; ID: ${aws_instance.myec2.id} ; AVAILIBLE_ZONE: ${aws_instance.myec2.availability_zone}; >> infos_ec2.txt"
  }

}
