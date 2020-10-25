variable "myinstance" {
  type    = "string"
  default = "t2.micro"
}

variable "mytag" {
  type = "map"
  default = {
    "Name" = "myec2tag"
  }
}

variable "name_sg_ec2" {
  type    = list
}
