resource "aws_rds_cluster_parameter_group" "backup_config" {
  name   = "db-backup-param-group"
  family = "mysql8.0"

  parameter {
    name  = "backup_retention_period"
    value = "7"
  }
}

# Automatically retains backups for 7 days and defines a preferred backup window

resource "aws_rds_cluster" "db_cluster" {
  cluster_identifier          = "webapp-db-cluster"
  engine                      = "mysql"
  engine_version              = "8.0"
  database_name               = "webapp"
  master_username             = var.db_username
  master_password             = var.db_password
  backup_retention_period     = 7
  preferred_backup_window     = "02:00-03:00"
  vpc_security_group_ids      = [aws_security_group.db_sg.id]
  db_subnet_group_name        = aws_db_subnet_group.db_subnet_group.name
}