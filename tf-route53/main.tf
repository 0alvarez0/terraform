resource "aws_vpc" "vpc1" {
  cidr_block           = var.vpccidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    "Name" = var.vpcname
  }
}

resource "aws_subnet" "publicsubnet1" {
  vpc_id                  = aws_vpc.vpc1.id
  cidr_block              = var.pubcidr
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"

  tags = {
    "Name" = var.pubsubnetname
  }
}

resource "aws_subnet" "publicsubnet2" {
  vpc_id                  = aws_vpc.vpc1.id
  cidr_block              = var.pubcidr2
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1b"

  tags = {
    "Name" = var.pubsubnetname2
  }
}

resource "aws_internet_gateway" "tfigw" {
  vpc_id = aws_vpc.vpc1.id

  tags = {
    "Name" = var.igname
  }
}

resource "aws_route_table" "pubrt" {
  vpc_id = aws_vpc.vpc1.id

  route {
    cidr_block = var.pubroutecidr
    gateway_id = aws_internet_gateway.tfigw.id
  }
  tags = {
    "Name" = "rt1"
  }
}

resource "aws_route_table_association" "pubrta1" {
  subnet_id      = aws_subnet.publicsubnet1.id
  route_table_id = aws_route_table.pubrt.id
}

resource "aws_route_table_association" "pubrta2" {
  subnet_id      = aws_subnet.publicsubnet2.id
  route_table_id = aws_route_table.pubrt.id
}

resource "aws_security_group" "sg1" {
  vpc_id      = aws_vpc.vpc1.id
  name        = "sg1"
  description = "sg for ssh and http"

  ingress {
    description = "inblund rule for http"
    from_port   = 80
    cidr_blocks = ["0.0.0.0/0"]
    to_port     = 80
    protocol    = "tcp"
  }

  ingress {
    description = "inblund rule for ssh"
    from_port   = 22
    cidr_blocks = ["0.0.0.0/0"]
    to_port     = 22
    protocol    = "tcp"
  }

  ingress {
    description = "inblund rule for https"
    from_port   = 443
    cidr_blocks = ["0.0.0.0/0"]
    to_port     = 443
    protocol    = "tcp"
  }

  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_route53_zone" "privzone1" {
  name          = "atlast.local"
  force_destroy = true
  depends_on    = [aws_vpc.vpc1]

  vpc {
    vpc_id = aws_vpc.vpc1.id
  }
}

resource "aws_instance" "vm1" {
  ami                    = "ami-0bb84b8ffd87024d8" //amazon linux
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.sg1.id]
  subnet_id              = aws_subnet.publicsubnet1.id
  depends_on             = [aws_security_group.sg1]
  user_data              = <<-EOF
  #!/bin/bash
  sudo yum update -y
  sudo yum install httpd -y
  sudo systemctl start httpd
  sudo systemctl enable httpd
  echo "Hi my name is $HOSTNAME" >> /var/www/html/index.html
  EOF
  tags = {
    Name = "HTTPVM53"
  }
}

resource "aws_route53_record" "record1" {
  name       = "www"
  type       = "A"
  zone_id    = aws_route53_zone.privzone1.id
  depends_on = [aws_instance.vm1]
  records    = [aws_instance.vm1.private_ip]
  ttl        = 300
}