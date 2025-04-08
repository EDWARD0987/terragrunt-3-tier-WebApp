provider "aws" {
  region = var.aws_region
}

resource "aws_security_group" "web_sg" {
  name        = "web-tier-sg"
  description = "Allow HTTP & HTTPS traffic"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
   egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # "-1" allows all protocols
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# resource "aws_alb" "web_alb" {
#   name               = "web-tier-alb"
#   load_balancer_type = "application"
#   security_groups    = [aws_security_group.web_sg.id]
#   subnets            = var.subnet_ids
# }
#TODO made change above to aws_lb
resource "aws_lb" "web_alb" {
  name               = "web-tier-alb"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.web_sg.id]
  subnets            = var.subnet_ids
}

resource "aws_launch_template" "web_lt" {
  name_prefix   = "web-launch-template"
  image_id      = var.ami_id
  instance_type = var.instance_type

  iam_instance_profile {
    name = var.iam_instance_profile
  }

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.web_sg.id]
  }

  user_data = base64encode(<<EOF
#!/bin/bash
sudo yum update -y
sudo yum install -y httpd
sudo systemctl start httpd
sudo systemctl enable httpd
echo "<h1>Hello World from $(hostname -f)</h1>" > /var/www/html/index.html
EOF
  )

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "Web-Tier-Instance"
    }
  }
}



resource "aws_autoscaling_group" "web_asg" {
  name                = "web-tier-asg"
  max_size            = var.max_instances
  min_size            = var.min_instances
  desired_capacity    = var.desired_instances
  vpc_zone_identifier = var.subnet_ids

  launch_template {
    id      = aws_launch_template.web_lt.id
    version = "$Latest"
  }
  
}


# Defining target groups  #TODO
resource "aws_lb_target_group" "web_tg" {
  name     = "web-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 2
  }
}
# Attaching target group to ASG
resource "aws_autoscaling_attachment" "web_asg_attachment" {
  autoscaling_group_name = aws_autoscaling_group.web_asg.id
  lb_target_group_arn    = aws_lb_target_group.web_tg.arn
}

# # attach LISTENER RULES FOR ALB  #todo
# resource "aws_lb_listener" "http" {
#   load_balancer_arn = aws_lb.web.arn
#   port              = 80
#   protocol          = "HTTP"
#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.web_tg.arn
#   }
# }

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.web_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_tg.arn
  }
}



# resource "aws_instance" "web_server" {
#   ami           = var.ami_id
#   instance_type = var.instance_type
#   subnet_id     = var.subnet_ids[0]

#   user_data = <<EOF
# #!/bin/bash
# sudo yum update -y
# sudo yum install -y httpd
# sudo systemctl start httpd
# sudo systemctl enable httpd
# echo "<h1>Hello World from $(hostname -f)</h1>" > /var/www/html/index.html
# EOF



#   tags = var.common_tags  #  Uses tags from Terragrunt inputs
# }

