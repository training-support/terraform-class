terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.0.0-beta3"
    }
  }

  backend "s3" {
    bucket = "terraformlvc-june25-terraform-state"
    key = "global/s3/terraform.tfstate"
    region = "ap-south-1"

    dynamodb_table = "terraformlvc_june25_terraform_locks"
    encrypt = true
  }
}

output "s3_bucket_arn" {
  value = aws_s3_bucket.terraform_state.arn
}

output "dynamodb_table_name" {
  value = aws_dynamodb_table.terraform_locks.name
}
