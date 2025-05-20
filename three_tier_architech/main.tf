terraform {
  required_providers {
    aws = {
       version = ">= 5.0.0"
    }
  }
}
provider "aws" {
  region     = var.region
  access_key = "***************"
  secret_key = "***********************"
}
resource "aws_vpc" "maxvpc" {
  cidr_block           = "10.0.0.0/24"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "my-vpc"
  }
}
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.maxvpc.id
  tags = {
    Name = "main-igw"
  }
}
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.maxvpc.id
  cidr_block              = "10.0.0.0/25"
  map_public_ip_on_launch = true
  availability_zone       = "ap-south-1a"
  tags = {
    Name = "public-subnet"
  }
}
resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.maxvpc.id
  cidr_block        = "10.0.0.128/25"
  availability_zone = "ap-south-1a"
  tags = {
    Name = "private-subnet"
  }
}
resource "aws_eip" "nat" {
  domain = "vpc"
  tags = {
    Name = "nat-eip"
  }
}
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public.id
  tags = {
    Name = "nat-gateway"
  }
}
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.maxvpc.id
  tags = {
    Name = "public-rtb"
  }
}
resource "aws_route" "public_internet_access" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}
resource "aws_route_table_association" "public_subnet" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.maxvpc.id
  tags = {
    Name = "private-rtb"
  }
}
resource "aws_route" "private_nat_access" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat.id
}
resource "aws_route_table_association" "private_subnet" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}
resource "aws_instance" "app_server" {
  ami           = var.ami_id # Replace with a valid AMI ID
  instance_type = var.instance_type
  key_name      = var.key_name
  subnet_id     = aws_subnet.public.id
  tags = {
    Name = "app-server"
  }
}

