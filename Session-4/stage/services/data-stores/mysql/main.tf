terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.0.0-beta3"
    }
  }

  backend "s3" {
    bucket = "terraformlvc-june25-terraform-state"
    key = "stage/mysql/terraform.tfstate"
    region = "ap-south-1"
    dynamodb_table = "terraformlvc_june25_terraform_locks"
    encrypt = true
  }
}


resource "aws_db_instance" "example" {
  identifier_prefix = "terraformlvc-june25"
  engine = "mysql"
  allocated_storage = 10
  instance_class = "db.t3.micro"
  skip_final_snapshot = true

  db_name = var.db_name
  username = var.db_username
  password = var.db_password
}
