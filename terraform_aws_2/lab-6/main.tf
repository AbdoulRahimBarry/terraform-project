provider "aws" {
  region     = "us-east-1"
  access_key = "AKIAW7UYPY6KTF5JSLET"
  secret_key = "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"
}

resource "aws_iam_user" "lb" {
  count = var.number_user
  name  = var.iam_name[count.index]
  path  = "/system/"
}
