provider "aws" {
  region     = "ap-south-1"
  access_key = "************"
  secret_key = "*************************"
}
resource "aws_vpc" "flip" {
  cidr_block          = "10.0.0.0/24"
  enable_dns_support  = true
  enable_dns_hostnames = true
  tags = {
    Name = "flip-vpc"
  }
}
resource "aws_subnet" "flip_public_subnet" {
  vpc_id                  = aws_vpc.flip.id
  cidr_block              = "10.0.0.0/25"
  availability_zone      = "ap-south-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "flip_public-subnet"
  }
}

output "vpc_id" {
  value = aws_vpc.flip.id
}
output "vpc_cidr_block" {
  value = aws_vpc.flip.cidr_block
}
output "subnet_id" {
  value = aws_subnet.flip_public_subnet.id
}
output "subnet_cidr_block" {
  value = aws_subnet.flip_public_subnet.cidr_block
}
