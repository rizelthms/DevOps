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

# exercise 4
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

#exercise 5
# resource "aws_instance" "main_instance" {
#   ami             = "ami-007855ac798b5175e"
#   instance_type   = "t2.micro"
#   subnet_id       = values(aws_subnet.my_subnet)[0].id
#   key_name        = "MainKey"
#   security_groups = [aws_security_group.main_security_group.id]

#   user_data = templatefile("${path.module}/templates/nginx_config.sh", {})

#   tags = {
#     Name = "MainInstance"
#   }
# }

resource "aws_launch_template" "main_launch_template" {
  name                   = "MainLaunchTemplate"
  image_id               = "ami-007855ac798b5175e"
  instance_type          = "t2.micro"
  key_name               = "MainKey"
  vpc_security_group_ids = [aws_security_group.main_security_group.id]
  user_data              = base64encode(file("${path.module}/templates/user_data.sh"))
}

resource "aws_autoscaling_group" "main_autoscaling_group" {
  name = "MainAutoscalingGroup"
  launch_template {
    id      = aws_launch_template.main_launch_template.id
    version = "$Latest"
  }
  vpc_zone_identifier       = values(aws_subnet.my_subnet)[*].id
  min_size                  = 2
  desired_capacity          = 2
  max_size                  = 4
  target_group_arns         = [aws_lb_target_group.main_target_group.arn]
  health_check_type         = "EC2"
  health_check_grace_period = 300

  tag {
    key                 = "Name"
    value               = "MainInstance"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }

  #   scaling_policy {
  #     policy_type = "TargetTrackingScaling"
  #     target_tracking_configuration {
  #       predefined_metric_specification {
  #         predefined_metric_type = "ASGAverageCPUUtilization"
  #       }
  #       target_value = 20
  #     }
  #   }
}

resource "aws_lb_target_group" "main_target_group" {
  name     = "MainTargetGroup"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main_vpc.id
  health_check {
    interval            = 30
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 10
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb_listener" "main_listener" {
  load_balancer_arn = aws_lb.main_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main_target_group.arn
  }
}

resource "aws_lb" "main_lb" {
  name               = "MainLoadBalancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.main_lb_sg.id]
  subnets            = values(aws_subnet.my_subnet)[*].id

  tags = {
    Name = "MainLoadBalancer"
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

resource "aws_security_group" "main_lb_sg" {
  name        = "MainLBSG"
  description = "Security group for the main load balancer"
  vpc_id      = aws_vpc.main_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "MainLBSG"
  }
}

# data "template_file" "user_data" {
#   template = file("${path.module}/templates/user_data.sh")
# }

output "load_balancer_dns_name" {
  value = aws_lb.main_lb.dns_name
}
