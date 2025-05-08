provider "aws" {
  region     = var.region
  access_key = "*********"
  secret_key = "******************
}
resource "aws_instance" "example_1" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  tags = {
    Name = "flipkart"
  }
  #attach 20 gb
  root_block_device {
    volume_size           = 20
    volume_type           = "gp3"
    delete_on_termination = true
  }
}
output "public_ip" {
  value = aws_instance.example_1.public_ip
}
output "private_ip" {
  value = aws_instance.example_1.private_ip
}

