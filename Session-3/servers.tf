resource "aws_instance" "simple_server" {
  ami = "ami-0b09627181c8d5778"
  instance_type = "t2.micro"
}
