variable "db_username" {
  description = "Username of the database"
  type = string
  sensitive = true
}

variable "db_password" {
  description = "Password of the database"
  type = string
  sensitive = true
}

variable "db_name" {
  description = "Name of the DB"
  type = string
}
