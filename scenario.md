1. Terraform migration ( using import and then running terraform import command which will create a state file).

- This will import the EC2 instance all details which was created manually.

- Importing EC2 instance to create a state file.

2. Terraform drift detection ( if some one manually changed any settings for any resource, then detecting that change is called drift detection).

--- There are 2 ways to detect it.-----------
Terraform Refresh: I use terraform refresh regularly (through a cron job or pipeline) to sync actual resource states with the Terraform state file. If there's a drift, terraform plan shows the difference.

Audit + Alerts: I use CloudTrail with CloudWatch Events and a Lambda notifier. This alerts me when sensitive resources are modified manually (e.g., by an IAM user). If changes are made by Terraform (using an assumed role or automation), it's expected — otherwise, I get alerted.

{
          {
  "source": ["aws.ec2", "aws.s3", "aws.rds"],
  "detail-type": ["AWS API Call via CloudTrail"],
  "detail": {
    "eventName": [
      "ModifyInstanceAttribute",
      "TerminateInstances",
      "PutBucketPolicy"
    ],
    "userIdentity.type": ["IAMUser"]
  }
}

