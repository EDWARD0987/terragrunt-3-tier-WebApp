# Recomended folder structure
# Setting up a Terragrunt folder structure properly ensures modular, reusable, and manageable infrastructure. Here's an optimal layout for a three-tier web architecture in AWS using Terragrunt

 Web Tier → Load balancer, EC2 instances, security groups
 App Tier → Auto Scaling Group, backend logic, IAM roles
 DB Tier → RDS database, subnet placement, backup configuration

 # Understanding the flow

 1 - App Tier (Backend servers) communicates securely with DB Tier.
 2 - Security Groups restrict access so that only the App Tier can reach the DB
 3 - Subnet Groups ensure multi-AZ deployment for high availability.
 4 - Backups keep historical data safe for recovery.

 In your Terragrunt folder structure, the  directory is where you store configurations that apply across all environments (e.g., , ). This ensures consistent infrastructure settings while keeping individual environment files cleaner.

# Purpose of Global
 Centralized Remote State Management
 Shared Provider Configurations (AWS, GCP, etc.)
 Common Backend Configurations (S3, DynamoDB for Terraform state locking)
 Reusable IAM Roles, Security Policies, or Defaults


terraform/
├── modules/
│   ├── web-tier/         # Web layer (ALB & EC2 instances)
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   ├── app-tier/         # Application layer (Auto Scaling & Backend)
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   ├── db-tier/          # Database layer (RDS setup)
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
├── environments/
│   ├── dev/              # Development environment configs
│   │   ├── terragrunt.hcl
│   ├── prod/             # Production environment configs
│   │   ├── terragrunt.hcl
├── global/               # Root configurations shared across modules
│   ├── terragrunt.hcl
│   ├── provider.tf
│   ├── backend.tf        # Defines remote backend


Understanding Each Part
modules/      → Contains Terraform modules for web-tier, app-tier, and db-tier.
Environment/  → Holds environment-specific Terragrunt configs for dev and prod.
Global/       → Stores common settings like the provider, backend, and shared security configurations.

# ENABLE REMOTE STATE IN TERRAGRUNT
We’ll use an AWS S3 bucket to store Terraform’s state files securely
