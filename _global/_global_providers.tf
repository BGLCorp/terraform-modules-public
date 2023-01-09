terraform {
  backend "s3" {}
}

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
  
  allowed_account_ids = var.aws_allowed_account_ids

  # Make it faster by skipping something: https://medium.com/@anton.babenko/make-terraform-faster-skip-unnecessary-checks-aws-and-s3-3ab00df9c3a9
  #skip_get_ec2_platforms      = true # deprecated
  #skip_metadata_api_check     = true # not tested
  #skip_region_validation      = true # not tested
  #skip_credentials_validation = true # not tested
}
