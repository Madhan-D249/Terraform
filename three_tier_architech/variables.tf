variable "region" {
  description = "AWS region for the deployment"
  type        = string
}
variable "ami_id" {
  description = "ami id for ec2 instance"
  type        = string
}
variable "instance_type" {
  description = "ec2-instance type"
  type        = string
}
variable "key_name" {
  description = "key pair for instance"
  type        = string
}
