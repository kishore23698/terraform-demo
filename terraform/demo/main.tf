provider "aws" {
  region     = "us-east-2"
}

module "my_vpc1" {
  source = "../modules/vpc"
  vpc_cidr = "10.0.0.0/16"
  tenancy = "default"
  vpc_id ="${module.my_vpc1.vpc_id}"
  subnet_cidr = "10.0.1.0/24"
}


module "my_ec21" {
  source = "../modules/ec2"
  ami_id = "ami-0960ab670c8bb45f3"
  instance_type = "t2.micro"
  subnet_id ="${module.my_vpc1.subnet_id}"
  key_name = "s1"
}