module "vpc_mod" {
  source = "./modules/vpc-modules"
  #vpc
  vpc_cidr = "10.0.0.0/24"
  tags     = "terraform_vpc"
  #public_subnet
  pubsub_cidr = "10.0.0.0/25"
  pubsub_tags = "pubsub_tf"
  #private_subnet
  prisub_cidr = "10.0.0.128/25"
  prisub_tags = "prisub_tf"
  #internet_gateway
  igw_tags = "igw_tf"
  #public_route_table
  pub_rt_cidr = "0.0.0.0/0"
  pub_rt_tags = "pubrt_tf"
  #nat_gateway
  nat_tags = "natgw_tf"
  #private_routetable
  pri_rt_cidr = "0.0.0.0/0"
  pri_rt_tags = "pri_rt_tf"
  #public_security_group
  pub_sg      = "sg_tf"
  from_port   = 0
  to_port     = 65535
  protocol    = "tcp"
  pub_sg_cidr = ["0.0.0.0/0"]
  #private_security_group
  pri_sg      = "private_sg"
  pri_sg_cidr = ["10.0.0.0/25"]
}
