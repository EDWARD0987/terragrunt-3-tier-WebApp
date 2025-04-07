variable "aws_region" { default = "us-east-1" }
variable "vpc_id" {}
variable "subnet_ids" { type = list(string) }
variable "ami_id" { default = "ami-00a929b66ed6e0de6" } # Replace with a your AMI ID
variable "instance_type" { default = "t2.micro" }
variable "min_instances" { default = 2 }
variable "max_instances" { default = 5 }
variable "desired_instances" { default = 3 }
variable "iam_instance_profile" { default = "SSMRoleForEC2"}



variable "tags" {   
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

# variable "iam_instance_profile" {
#   description = "The name of the IAM instance profile to attach to EC2 instances"
#   type        = string
#   default     = "SSMRoleForEC2"  # You can set a default or leave it unset
# }