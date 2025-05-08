provider "aws" {
  region     = "ap-south-1"
  access_key = "************"
  secret_key = "**************************"
}
resource "aws_instance" "example_1" {
  ami           = "ami-03edbe403ec8522ed"
  instance_type = "t2.micro"
  key_name      = "maxxy"
  tags = {
    Name = "production"
  }
  security_groups =[aws_security_group.example_sg.name]
  #attach 20 gb
  root_block_device{
    volume_size=20
    volume_type="gp3"
    delete_on_termination=true
  }
}
resource "aws_security_group" "example_sg" {
  tags = {
    Name = "securityexample"
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
