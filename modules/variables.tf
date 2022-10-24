variable "vpc_cidr" {
type = string
description = "cidr range for vpc"
}
variable "tags" {
type = string
description = "tags for vpc"
}
variable "pubsub_cidr" {
type = string
description = "public_subnet cidr range"
}
variable "pubsub_tags" {
type = string
description = "tags for public_subnet"
}
variable "prisub_cidr" {
type = string
description = "private_subnet cidr range"
}
variable "prisub_tags" {
type = string
description = "tags for public_subnet"
}
variable "igw_tags" {
type = string
description = "tags for internet_gateway"
}
variable "pub_rt_cidr" { 
type = string
description = "route table cidr_blocks"
}
variable "pub_rt_tags" {
type = string
description = "public route_table"
}
variable "nat_tags" {
type = string
description = "tags for nat_gateway"
}
variable "pri_rt_cidr" {
type = string
description = "private route_table cidr blocks"
}
variable "pri_rt_tags" {
type = string
description = "private route_table tags"
}
variable "pub_sg" {
type = string
description = "security_group tags"
}
variable "from_port" {
type = number
description = "ingress from_port"
}
variable "to_port" {
type = number
description = "ingress to_port"
}
variable "protocol" {
type = string
description = "protocol name"
}
variable "pub_sg_cidr" {
type = list
description = "cidr_block for security group"
}
variable "pri_sg" {
type = string
description = "configured security group"
}
variable "pri_sg_cidr" {
type = list
description = "private security_group cidr_blocks"
}