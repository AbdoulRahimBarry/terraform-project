provider "aws" {
  region     = "us-east-1"
  access_key = ""
  secret_key = "T9+/sv4"
}

terraform {
  backend "s3" {
    bucket = "terraform-backend-abdoul"
    key    = "prod.tfstate"
    region = "us-east-1"
    access_key = ""
    secret_key = "T9+/sv4"
  }
}

module "ec2-module" {
  source = "../modules/ec2module"

  mytag = {
    Name = "mytag-prod"
  }

  myinstance = "t2.micro"
  mysecgroup = "security-group-prod"
}
