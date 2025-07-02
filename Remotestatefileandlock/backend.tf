terraform {
  backend "s3" {
    bucket = "my-tf-test-bucket-maximus-maddy"
    key    = "maximus/terraform.tfstate"
    region = "ap-south-1"
    aws_dynamodb_table = "dynamodb-terraform-state-lock"
  }
}
