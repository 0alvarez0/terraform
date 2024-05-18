resource "aws_instance" "myinstance" {
  availability_zone = "us-east-1b"
  ami               = "ami-04b70fa74e45c3917"
  instance_type     = "t2.micro"
  tags = {
    "Name" = "testec2"
  }
}