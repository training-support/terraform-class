include "root" {
  path = find_in_parent_folders("root.hcl")
}

inputs = {
  environment = "stage"
  instance_type = "t2.micro"
}
