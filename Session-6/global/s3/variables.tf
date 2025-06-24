variable "bucket_name" {
  description = "The name of the S3 Bucket for holding state. Must be globally unique."
  type = string
  default = "terraformlvc-june25-terraform-state"
}

variable "table_name" {
  description = "The name of the DynamoDB table. Must be unique in this AWS account."
  type = string
  default = "terraformlvc_june25_terraform_locks"
}
