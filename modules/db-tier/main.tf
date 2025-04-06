provider "aws" {
  region = var.aws_region
}

# Defines access control, ensuring that only the App Tier can connect to the DB

resource "aws_security_group" "db_sg" {
  name        = "db-tier-sg"
  description = "Allow database access from app tier"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 3306  # MySQL Example
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = var.app_tier_cidr_blocks
  }
}

# Ensures the database is deployed across multiple availability zones for high availability.

resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "db-subnet-group"
  subnet_ids = var.subnet_ids
}


# Defines the actual database instance with configurations for storage, security, and retention.

resource "aws_db_instance" "db_instance" {
  identifier           = "webapp-db"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = var.instance_type
  allocated_storage    = var.db_storage_size
  storage_type         = "gp2"
  username             = var.db_username
  password             = var.db_password
  publicly_accessible  = false
  vpc_security_group_ids = [aws_security_group.db_sg.id]
  db_subnet_group_name = aws_db_subnet_group.db_subnet_group.name
  backup_retention_period = 7
}