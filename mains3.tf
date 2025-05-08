provider "aws" {
  region     = "ap-south-1"
  access_key = "************"
  secret_key = "******************"
}
resource "aws_s3_bucket" "maxxymus" {
  bucket = "maxxymus"

  versioning {
    enabled = true
  }
  acl = "private"
  tags = {
    Name = "maxxymus"
  }
}

resource "aws_s3_bucket_public_access_block" "maxxymus_access_block" {
  bucket                  = aws_s3_bucket.maxxymus.bucket
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

output "bucket_name" {
  value = aws_s3_bucket.maxxymus.bucket
}
output "bucket_path" {
  value = "s3://${aws_s3_bucket.maxxymus.bucket}"
}
