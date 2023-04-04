provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "main_vpc" {
  cidr_block = "10.0.0.0/16"

    tags = {
    Name = "MainVpc"
  }
}

resource "aws_subnet" "my_subnet" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = "10.0.1.0/24"
  map_public_ip_on_launch = true

    tags = {
    Name = "Subnet1"
  }
}
