provider "aws" {
  region     = "us-east-1"
  access_key = "YOU ACCES KEY"
  secret_key = "YOU SECRET KEY"
}

resource "aws_iam_user" "lb" {
  count = var.number_user
  name  = var.iam_name[count.index]
  path  = "/system/"
}
