provider "aws" {
  region     = "ap-south-1"
  access_key = ""
  secret_key = ""
}
resource "aws_instance" "example_1" {
  ami           = "ami-03edbe403ec8522ed"
  instance_type = "t2.micro"
  key_name      = "maxxy"
  tags = {
    Name = "maxxyserver"
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
  value = aws_instance.example_1.public_ip
}
output "private_ip" {
  value = aws_instance.example_1.private_ip
}
