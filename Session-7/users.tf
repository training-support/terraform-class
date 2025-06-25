# variable "user_names" {
#   description = "Create IAM users with these names"
#   type = list(string)
#   default = [ "A", "B", "C", "D", "E" ]
# }

# resource "aws_iam_user" "dept_users" {
#   count = length(var.user_names)
#   name = var.user_names[count.index]
# }
