provider "aws" {
  region     = "us-east-1"
  access_key = ""
  secret_key = "T9+/sv4"
}

terraform {
  backend "s3" {
    bucket = "terraform-backend-abdoul"
    key    = "dev.tfstate"
    region = "us-east-1"
    access_key = ""
    secret_key = ""
  }
}

module "ec2-module" {
  source = "../modules/ec2module"

  mytag = {
    Name = "mytag-dev"
  }

  myinstance = "t2.nano"
  mysecgroup = "security-group-dev"
}
