variable "db_username" {
  description = "Username of the database"
  type = string
  default = "abhiram"
  sensitive = true
}

variable "db_password" {
  description = "Password of the database"
  type = string
  default = "asdf12345asdf"
  sensitive = true
}

variable "db_name" {
  description = "Name of the DB"
  type = string
  default = "example_database_prod"
}
