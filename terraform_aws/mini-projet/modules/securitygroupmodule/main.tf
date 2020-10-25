resource "aws_security_group" "allow_traffic" {
  name        = var.name_sec_group
  description = "Allow ssh, http and https inbound traffic"

  ingress {
    description = "https from VPC"
    from_port   = var.myhttps
    to_port     = var.myhttps
    protocol    = "tcp"
    cidr_blocks = ["${var.mycidr}"]
  }

  ingress {
    description = "http from VPC"
    from_port   = var.myhttp
    to_port     = var.myhttp
    protocol    = "tcp"
    cidr_blocks = ["${var.mycidr}"]
  }

  ingress {
    description = "ssh from VPC"
    from_port   = var.myssh
    to_port     = var.myssh
    protocol    = "tcp"
    cidr_blocks = ["${var.mycidr}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["${var.mycidr}"]
  }
}
