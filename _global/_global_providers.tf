terraform {
  backend "s3" {}
}

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
  
  allowed_account_ids = var.aws_allowed_account_ids

  # Make it faster by skipping something
  skip_get_ec2_platforms = true
}
