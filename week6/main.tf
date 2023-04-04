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

resource "aws_internet_gateway" "main_igw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "MainIGW"
  }
}

resource "aws_route_table" "main_route_table" {
vpc_id = aws_vpc.main_vpc.id

route{
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main_igw.id
}
  tags = {
    Name = "MainRouteTable"
  }
}

resource "aws_route_table_association" "main_route_table_association" {
    subnet_id = aws_subnet.my_subnet.id
    route_table_id = aws_route_table.main_route_table.id
}

resource "aws_instance" "main_instance" {
  ami = "ami-007855ac798b5175e"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.my_subnet.id
  key_name      = "MainKey"
  security_groups = [aws_security_group.main_security_group.id]

  user_data = templatefile("${path.module}/templates/nginx_install.sh", {})

      tags = {
    Name = "MainInstance"
  }
}

resource "aws_security_group" "main_security_group" {
  name = "MainSG"
  vpc_id = aws_vpc.main_vpc.id
  
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    }

   egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
   }
}
