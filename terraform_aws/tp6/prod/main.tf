provider "aws" {
  region     = "us-east-1"
  access_key = "YOU ACCES KEY"
  secret_key = "YOU SECRET KEY"
}

terraform {
  backend "s3" {
    bucket = "terraform-backend-abdoul"
    key    = "prod.tfstate"
    region = "us-east-1"
    access_key = "YOU ACCES KEY"
    secret_key = "YOU SECRET KEY"
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
