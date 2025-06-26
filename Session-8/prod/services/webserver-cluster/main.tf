module "webserver-cluster" {
  source = "../../../modules/services/webserver-cluster"

  cluster_name = var.cluster_name
  db_remote_state_bucket = var.db_remote_state_bucket
  db_remote_state_key = var.db_remote_state_key
}


resource "aws_autoscaling_schedule" "business_hours" {
  scheduled_action_name = "business_hours"
  min_size = 2
  max_size = 10
  desired_capacity = 10
  recurrence = "0 9 * * *"
  autoscaling_group_name = module.webserver-cluster.asg_name
}

resource "aws_autoscaling_schedule" "overnight" {
  scheduled_action_name = "overnight"
  min_size = 2
  max_size = 10
  desired_capacity = 2
  recurrence = "0 17 * * *"
  autoscaling_group_name = module.webserver-cluster.asg_name
}
