

variable "aws_region" { default = "us-east-1" }
variable "vpc_id" {}
variable "subnet_ids" { type = list(string) }
variable "ami_id" { default = "ami-00a929b66ed6e0de6" } # Replace with a your AMI ID
variable "instance_type" { default = "t2.micro" }
variable "min_instances" { default = 2 }
variable "max_instances" { default = 5 }
variable "desired_instances" { default = 3 }



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

variable "patch_baseline_name" {
  description = "Name of the patch baseline."
  type        = string
}

variable "approved_patches" {
  description = "List of approved patches (e.g., KB numbers)."
  type        = list(string)
}

variable "operating_system" {
  description = "Target operating system (e.g., AMAZON_LINUX_2, WINDOWS)."
  type        = string
}

variable "patch_filter_products" {
  description = "List of products to include in patching."
  type        = list(string)
}

variable "approve_after_days" {
  description = "Number of days to wait before approving patches."
  type        = number
}

variable "patch_group_name" {
  description = "Name of the patch group."
  type        = string
}

variable "maintenance_window_name" {
  description = "Name of the maintenance window."
  type        = string
}

variable "maintenance_window_schedule" {
  description = "Schedule for the maintenance window (e.g., cron expression)."
  type        = string
}

variable "maintenance_window_duration" {
  description = "Duration of the maintenance window in hours."
  type        = number
}

variable "maintenance_window_cutoff" {
  description = "Cutoff time in hours before the maintenance window ends."
  type        = number
}

variable "environment" {
  description = "Environment tag (e.g., dev, staging, prod)."
  type        = string
}
