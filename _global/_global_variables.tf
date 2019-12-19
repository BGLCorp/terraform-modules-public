variable "aws_profile" {
  type        = string
  description = "The AWS profile to use when interacting with the AWS API"
}

variable "aws_region" {
  type        = string
  description = "A single string for the AWS region"
}

variable "terraform_state_s3_bucket" {
  type        = string
  default     = ""
  description = "The name of the S3 bucket that holds Terraform state"
}

variable "terraform_state_s3_bucket_region" {
  type        = string
  default     = ""
  description = "The region that var.terraform_state_s3_bucket is in"
}

variable "terraform_state_dynamodb_table" {
  type        = string
  default     = ""
  description = "The name of the DynamoDB table that holds Terraform lock state"
}

variable "aws_allowed_account_ids" {
  type        = list
  description = "List of allowed AWS accounts where this configuration can be applied"
}