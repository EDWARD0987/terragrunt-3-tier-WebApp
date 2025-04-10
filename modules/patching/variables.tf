

variable "patch_baseline_name" {
  type        = string
  description = "Name of the Patch Baseline"
}

variable "patch_group_name" {
  type        = string
  description = "Name of the Patch Group"
}

variable "operating_system" {
  type        = string
  description = "Target OS for patching (e.g., AMAZON_LINUX_2)"
}

variable "approve_after_days" {
  type        = number
  description = "Days before automatic patch approval"
}

variable "environment" {
  type        = string
  description = "Deployment environment (dev, staging, prod)"
}