remote_state {
  backend = "s3"
  config = {
    bucket = "terraformlvc-june25-terraform-state"
    key = "${path_relative_to_include()}/terraform.tfstate"
    region = "ap-south-1"
    dynamodb_table = "terraformlvc_june25_terraform_locks"
    encrypt = true
  }
  generate = {
    path = "backend.tf"
    if_exists = "overwrite"
  }
}

terraform {
  source = "./"
}
