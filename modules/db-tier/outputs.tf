output "db_endpoint" {
  value = aws_db_instance.db_instance.endpoint
}

output "db_cluster_identifier" {
  value = aws_rds_cluster.db_cluster.cluster_identifier
}