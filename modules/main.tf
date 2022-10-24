resource "aws_vpc" "myvpc" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"

  tags = {
    Name = var.tags
  }
}
resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = var.pubsub_cidr  #cidr range for public_subnet

  tags = {
    Name = var.pubsub_tags #tags for public_subnet
  }
}
resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = var.prisub_cidr #cidr range for private_subnet

  tags = {
    Name = var.prisub_tags #tags for private_subnet
  }
}
resource "aws_internet_gateway" "tigw" {
  vpc_id = aws_vpc.myvpc.id

  tags = {
    Name = var.igw_tags #tags for internet_gateway
  }
}
resource "aws_route_table" "pubrt" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = var.pub_rt_cidr #cidr for public_routetable
    gateway_id = aws_internet_gateway.tigw.id
  }
  tags = {
    Name = var.pub_rt_tags #tags for public
  }
}
resource "aws_route_table_association" "pubassociation" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.pubrt.id
}
resource "aws_eip" "eip" {
  vpc      = true
}
resource "aws_nat_gateway" "tnat" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.pubsub.id
  tags = {
    Name = var.nat_tags #tags for nat_gateway
  }
}
resource "aws_route_table" "privrt" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = var.pri_rt_cidr #cidr for private_routetable
    gateway_id = aws_nat_gateway.tnat.id
  }
   tags = {
    Name = var.pri_rt_tags #tags for private_routetable
  }
}
resource "aws_route_table_association" "privassociation" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.privrt.id
}
resource "aws_security_group" "allow_all" {
  name        = var.pub_sg #tags for public_security_group
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.myvpc.id
    ingress {
      from_port = var.from_port #ingress from_port
      to_port = var.to_port #ingress to_port
      protocol = var.protocol #protocol_name
      cidr_blocks = var.pub_sg_cidr #cidr_blocks for security groups
      }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.pub_sg 
  }
}
resource "aws_security_group" "allow_pub_sg" {
    name        = var.pri_sg #tags for private_security_group
    description = "Allow authenticated public machine user"
    vpc_id      = aws_vpc.myvpc.id

    ingress {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = var.pri_sg_cidr #cidr_blocks allows only public_subnet cidr_range 
    }
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
      }


    tags = {
        Name = var.pri_sg #tags for private_security_groups
    }
}

