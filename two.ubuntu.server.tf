
provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}
resource "aws_instance" "example" {
  count         = 2
  ami           = var.ami_id # Replace with a valid AMI ID
  instance_type = var.instance_type
  key_name      = var.key_name
  tags = {
    Name = "ubuntu-server-${count.index + 1}" # Creates unique names for each instance
  }
  security_groups = [aws_security_group.example_sg.name]
  user_data       = file("sample.sh")
}
resource "aws_security_group" "example_sg" {
  tags = {
    Name = "securityexample"
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
output "public_ip" {
  value = aws_instance.example[*].public_ip
}
output "private_ip" {
  value = aws_instance.example[*].private_ip
}

