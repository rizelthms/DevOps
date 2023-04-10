provider "aws" {
  region = "us-east-1"
}

variable "subnets" {
  type    = set(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

resource "aws_vpc" "main_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "MainVpc"
  }
}

resource "aws_subnet" "my_subnet" {
  for_each                = toset(var.subnets)
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = each.value
  map_public_ip_on_launch = true

  tags = {
    Name = "Subnet${each.key}"
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

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main_igw.id
  }
  tags = {
    Name = "MainRouteTable"
  }
}

resource "aws_route_table_association" "main_route_table_association" {
  for_each       = aws_subnet.my_subnet
  subnet_id      = each.value.id
  route_table_id = aws_route_table.main_route_table.id
}

# resource "aws_instance" "main_instance" {
#   ami             = "ami-007855ac798b5175e"
#   instance_type   = "t2.micro"
#   subnet_id       = aws_subnet.my_subnet.id
#   key_name        = "MainKey"
#   security_groups = [aws_security_group.main_security_group.id]

#   user_data = templatefile("${path.module}/templates/nginx_config.sh", {})

#   tags = {
#     Name = "MainInstance"
#   }
# }
resource "aws_instance" "main_instance" {
  ami             = "ami-007855ac798b5175e"
  instance_type   = "t2.micro"
  subnet_id       = values(aws_subnet.my_subnet)[0].id
  key_name        = "MainKey"
  security_groups = [aws_security_group.main_security_group.id]

  user_data = templatefile("${path.module}/templates/nginx_config.sh", {})

  tags = {
    Name = "MainInstance"
  }
}

resource "aws_security_group" "main_security_group" {
  name   = "MainSG"
  vpc_id = aws_vpc.main_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
