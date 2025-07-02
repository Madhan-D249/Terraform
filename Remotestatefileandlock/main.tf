provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}

resource "aws_instance" "example_region" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [var.sg_id]

  tags = {
    Name = "maxxyy"
  }
}

resource "aws_s3_bucket" "example" {
  bucket = "my-tf-test-bucket-maximus-maddy"

  tags = {
    Name        = "Mybucket"
  }
}
resource "aws_dynamodb_table" "dynamodb-terraform-state-lock" {
  name = "terraform-state-lock-dynamo"
  hash_key = "LockID"
 
  attribute {
    name = "LockID"
    type = "S"
  }
}

output "instance_public_ip" {
  value = aws_instance.example_region.public_ip
}

output "instance_private" {
  value = aws_instance.example_region.private_ip
}
