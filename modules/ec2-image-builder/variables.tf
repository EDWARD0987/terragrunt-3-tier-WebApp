variable "pipeline_name" {
  description = "The name of the EC2 Image Builder pipeline"
  type        = string
}

variable "pipeline_description" {
  description = "Description for Image Builder pipeline"
  type        = string
  default     = "Automated AMI creation pipeline"
}

variable "recipe_name" {
  description = "The name of the image recipe"
  type        = string
}

variable "base_ami" {
  description = "Base AMI ID for EC2 Image Builder"
  type        = string
}

variable "recipe_version" {
  description = "Version of the image recipe"
  type        = string
  default     = "1.0.0"
}

variable "image_components" {
  description = "List of Image Builder components to install"
  type        = list(string)
  default     = [
    "arn:aws:imagebuilder:us-east-1:aws:component/update-linux/1.0.0",
    "arn:aws:imagebuilder:us-east-1:aws:component/install-nginx/1.0.0"
  ]
}

variable "infra_name" {
  description = "Infrastructure configuration name"
  type        = string
}

variable "instance_types" {
  description = "EC2 instance types for Image Builder"
  type        = list(string)
  default     = ["t3.micro"]
}

variable "security_group_id" {
  description = "Security group ID"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID"
  type        = string
}

variable "iam_role_arn" {
  description = "IAM role ARN for EC2 Image Builder"
  type        = string
}

variable "instance_profile_name" {
  description = "Instance profile name required for EC2 Image Builder"
  type        = string
}