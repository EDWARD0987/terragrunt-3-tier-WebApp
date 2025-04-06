# Defines access control, ensuring that only the App Tier can connect to the DB

resource "aws_security_group" "db_sg" {
  name        = "db-tier-sg"
  description = "Allow database access only from app tier"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 3306  # Example for MySQL
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = var.app_tier_cidr_blocks
  }
}