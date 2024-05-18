resource "aws_instance" "instance1" {
  ami = var.ami
  instance_type = var.itype
  availability_zone = var.az
  tags = {
    "Name" = var.instancename 
  }
}