# variable "should_create_instances" {
#   type = bool
#   default = true
# }

# variable "ec2_configs" {
#   description = "A map of EC2 instance configs"
#   type = map(object({
#     instance_type = string
#   }))
#   default = {
#     "web-server-dev" = {
#       instance_type = "t3.small"
#     },
#     "app-server-dev" = {
#       instance_type = "t3.small"
#     },
#     "worker-test" = {
#       instance_type = "t3.medium"
#     }
#   }
# }

# data "aws_ami" "amazon_linux_2" {
#   most_recent = true
#   owners = ["amazon"]

#   filter {
#     name = "name"
#     values = ["amzn2-ami-hvm-*-x86_64-gp2"]
#   }

#   filter {
#     name = "virtualization-type"
#     values = ["hvm"]
#   }
# }

# data "aws_vpc" "default" {
#   default = true
# }

# resource "aws_security_group" "ssh_access" {
#   name = "ssh_access_sg"
#   description = "Allows inbound SSH access"
#   vpc_id = data.aws_vpc.default.id

#   ingress {
#     from_port = 22
#     to_port = 22
#     protocol = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   egress {
#     from_port = 0
#     to_port = 0
#     protocol = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = "SSH Access SG"
#   }
# }

# resource "aws_key_pair" "abhiram-ssh-key" {
#   key_name = "abhiram-ssh-key"
#   public_key = file("~/.ssh/id_ed25519.pub")
# }

# resource "aws_instance" "my_servers" {
#   count = var.should_create_instances ? 1 : 0
#   for_each = var.ec2_configs

#   ami = data.aws_ami.amazon_linux_2.id
#   instance_type = each.value.instance_type

#   key_name = aws_key_pair.abhiram-ssh-key.key_name

#   vpc_security_group_ids = [aws_security_group.ssh_access.id]

#   associate_public_ip_address = true

#   tags = {
#     Name = each.key
#   }
# }

# output "instance_public_ips" {
#   value = {
#     for name, instance in aws_instance.my_servers : name => instance.public_ip
#   }
# }
