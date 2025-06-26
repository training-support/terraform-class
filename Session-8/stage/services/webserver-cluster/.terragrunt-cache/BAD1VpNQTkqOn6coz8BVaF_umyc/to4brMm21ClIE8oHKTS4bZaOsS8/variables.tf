variable "cluster_name" {
  description = "The name to use for all cluster resources"
  type = string
}

variable "server_port" {
  description = "The port on which the servers will listen"
  type = number
}

variable "min_size" {
  type = number
}

variable "max_size" {
  type = number
}

variable "db_address" {
  type = string
}

variable "db_port" {
  type = number
}
