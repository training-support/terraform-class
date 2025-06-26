include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../../../../modules/data-stores/mysql"
}

inputs = {
  db_name = "staging_database"
  db_username = "admin"
  db_password = "asdf12345asdf"
}
