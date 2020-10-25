provider "aws" {
  region     = "us-east-1"
  access_key = "YOU ACCES KEY"
  secret_key = "YOU SECRET KEY"
}

terraform {
  backend "s3" {
    bucket = "terraform-backend-abdoul"
    key    = "app.tfstate"
    region = "us-east-1"
    access_key = "YOU ACCES KEY"
    secret_key = "YOU SECRET KEY"
  }
}

module "securitygroupmodule" {
  source = "../modules/securitygroupmodule"
}

module "ec2_module" {
  source = "../modules/ec2module"

  mytag = {
    Name = "mytag-apps"
  }
 
  myinstance = "t2.nano"
  name_sg_ec2 =["${module.securitygroupmodule.sec_grp_name}"]
}

module "eip-module" {
  source = "../modules/eipmodule"
  eip_ident = module.ec2_module.instance_id_ec2
}

module "ebs-module-aps" {
  source = "../modules/ebsmodule"
  ebs_var_id = module.ec2_module.instance_id_ec2
}
