variable "aws_region" { default = "us-east-1" }
variable "vpc_id" {}
variable "subnet_ids" { type = list(string) }
variable "instance_type" { default = "db.t3.micro" }
variable "db_storage_size" { default = 20 }
variable "db_username" { default = "admin" }
variable "db_password" {}
variable "app_tier_cidr_blocks" { type = list(string) }



variable "tags" {    #TODO
  type = map(string)
  description = "Tags for AWS resources"
}   

variable "common_tags" {
  type = map(string)
  description = "Global tags applied to all resources"
  default = {
    Owner       = "Edward"
    Project     = "Three-Tier Web App"
    Environment = "dev"
    CostCenter  = "Development"
  }
}