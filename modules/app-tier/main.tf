provider "aws" {
  region = var.aws_region
}

resource "aws_security_group" "app_sg" {
  name        = "app-tier-sg"
  description = "Allow only internal traffic"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = var.web_tier_cidr_blocks
  }
}

resource "aws_launch_configuration" "app_lc" {
  name          = "app-launch-config"
  image_id      = var.ami_id
  instance_type = var.instance_type
  security_groups = [aws_security_group.app_sg.id]

user_data = <<EOF
#!/bin/bash
sudo yum update -y
sudo yum install -y httpd
sudo systemctl start httpd
sudo systemctl enable httpd
echo "<h1>Hello World from $(hostname -f)</h1>" > /var/www/html/index.html
EOF
}

resource "aws_autoscaling_group" "app_asg" {
  name                 = "app-tier-asg"
  launch_configuration = aws_launch_configuration.app_lc.id
  min_size             = var.min_instances
  max_size             = var.max_instances
  desired_capacity     = var.desired_instances
  vpc_zone_identifier  = var.subnet_ids
}



