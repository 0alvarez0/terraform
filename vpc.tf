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

resource "aws_subnet" "privatesubnet1" {
  vpc_id            = aws_vpc.vpc1.id
  cidr_block        = var.privcidr
  availability_zone = "us-east-1b"

  tags = {
    "Name" = var.privsubnetname
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
}

resource "aws_route_table_association" "pubrta" {
  subnet_id      = aws_subnet.publicsubnet1.id
  route_table_id = aws_route_table.pubrt.id
}

resource "aws_nat_gateway" "tfngw" {
  subnet_id         = aws_subnet.privatesubnet1.id
  connectivity_type = "private"

  tags = {
    "Name" = var.ngname
  }
}

