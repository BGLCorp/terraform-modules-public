data "terraform_remote_state" "regional_data" {
  backend = "s3"

  config = {
    key            = "terragrunt/${var.aws_region}/_regional/regional_data/terraform.tfstate"
    bucket         = var.terraform_state_s3_bucket
    region         = var.terraform_state_s3_bucket_region
    dynamodb_table = var.terraform_state_dynamodb_table
    profile        = var.aws_profile
  }
}