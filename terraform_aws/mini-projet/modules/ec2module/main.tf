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

  security_groups = var.name_sg_ec2

  tags = var.mytag

  root_block_device {
    delete_on_termination = true
  }
}
