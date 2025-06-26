include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../../../modules/services/webserver-cluster"
}

dependency "mysql" {
  config_path = "../data-stores/mysql"

  mock_outputs = {
    db_address = "mock-db-address"
    db_port = 3306
  }
}

inputs = {
  cluster_name = "webserver-stage"
  db_address = dependency.mysql.outputs.db_address
  db_port = dependency.mysql.outputs.db_port
  server_port = 8080
  min_size = 2
  max_size = 6
}
