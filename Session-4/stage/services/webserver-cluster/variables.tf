variable "server_port" {
  description = "The port on which the servers will listen"
  type = number
  default = 8080
}

variable "db_remote_state_bucket" {
  type = string
  description = "Name of the S3 bucket that stores the state"
  default = "terraformlvc-june25-terraform-state"
}

variable "db_remote_state_key" {
  type = string
  description = "Key in the S3 bucket that stores the state"
  default = "stage/mysql/terraform.tfstate"
}
