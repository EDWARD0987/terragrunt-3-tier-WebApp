variable "aws_region" { default = "us-east-1" }
variable "vpc_id" {}
variable "subnet_ids" { type = list(string) }
variable "ami_id" { default = "ami-12345678" }
variable "instance_type" { default = "t3.medium" }
variable "min_instances" { default = 2 }
variable "max_instances" { default = 5 }
variable "desired_instances" { default = 3 }
variable "web_tier_cidr_blocks" { type = list(string) }


variable "tags" {           # TODO
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