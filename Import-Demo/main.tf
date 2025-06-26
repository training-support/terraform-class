terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.0.0-beta3"
    }
  }
}

resource "aws_s3_bucket" "manually-created" {
  bucket = "manually-created-tf-bucket1237987"
  region = "ap-south-1"

}


import {
  to = aws_s3_bucket.manually-created
  id = "manually-created-tf-bucket1237987"
}
