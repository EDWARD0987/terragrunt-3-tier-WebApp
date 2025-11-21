Getting started overview => https://terragrunt.gruntwork.io/docs/getting-started/overview/

# BEST PRACTICES
# Recomended folder structure
# Setting up a Terragrunt folder structure properly ensures modular, reusable, and manageable infrastructure. Here's an optimal layout for a three-tier web architecture in AWS using Terragrunt

1 - modularize your infra

    define seperate modules for each tier => WEB , APP , DATABASE

2 -  Use Terragrunt Hierarchy for DRY Code

     Reduce duplication across environments using terragrunt.hcl files => root.hcl inside main directory
     This allows each environment to reuse common configurations while modifying specifics per tier

3 - Secure Networking & IAM

     Restrict public exposure:
        WEB TIER   => Public subnets (ALB)  =>  Load balancer, EC2,SG.Auto Scaling Group (ASG) or ECS service scaling
        APP TIER   => Private subnets  =>  Backend logic, IAM roles,ECS task auto-scaling based on CPU & Memory utilization
        DB TIER    => Private subnets  =>   RDS database, subnet placement, backup configurationUse Multi-AZ for high availability.
        Define IAM Roles with least priviledges
     
# Terragrunt dependency management

Make sure each module correctly references dependencies
This ensures  dependencies are resolved before applying the module
 

 # Understanding the flow

 1 - App Tier (Backend servers) communicates securely with DB Tier.

 2 - Security Groups restrict access so that only the App Tier can reach the DB.

 3 - Subnet Groups ensure multi-AZ deployment for high availability.

 4 - Backups keep historical data safe for recovery.

 In your Terragrunt folder structure, the  directory is where you store configurations that apply across all environments (e.g., , ). This ensures consistent infrastructure settings while keeping individual environment files cleaner.

# Purpose of Global
For global configurations in Terragrunt, you’ll want a centralized setup that ensures consistency across environments while minimizing duplication. Here’s how you can structure it effectively
Define a  directory in your repository to store common configurations => global-configs
Use a Global terragrunt.hcl File => globla-config/terragrunt.hcl
This file should contain shared configurations like remote state, common inputs, and environment settings

 Centralized IAM Role Management
 To streamline IAM permissions, define common roles in your global-config/terragrunt.hcl file
 EXAMPLE GLOBAL IAM CONFIG

 inputs = {
  iam_role_arn = "arn:aws:iam::123456789012:role/app-tier-role"
} 
THEN REFERENCE THIS WITHIN EACH MODULE


# GLOBAL NETWORK SETTINGS=> VPC CIDR ranges, subnet allocations, and security group rules to ensure a robust and scalable infrastructure.
In Terragrunt, you use include.locals to reference variables from an included configuration file, like your global Terragrunt settings. Here’s how you properly define and access private subnets from your global config
Example Global VPC ConfiG

inputs = {

  vpc_id = "vpc-abc123"
  
  public_subnets  = ["subnet-111", "subnet-222"]
  
  private_subnets = ["subnet-333", "subnet-444"]
}

Each module should reference global network settings to avoid inconsistencies
To retrive private subnets use  include.locals 


EXAMPLE 

include {
 
  path = "../../global-configs/terragrunt.hcl"
}

inputs = {
 
  db_engine = "postgres"
 
  allocated_storage = 50
 
  vpc_id = include.locals.vpc_id
 
  private_subnets = include.locals.private_subnets
}


Global vpc cidr => global-configs/terragrunt.hcl
EXAMPLE

locals {
 
  vpc_cidr = "10.0.0.0/16"
}

Then referece it in each module

EXAMPLE
include {
  
  path = "../../global-configs/terragrunt.hcl"
}

inputs = {
  
  vpc_cidr = include.locals.vpc_cidr
}



Ensure consistent subnet allocation by defining VPC and subnet settings globally



 Centralized Remote State Management

 Shared Provider Configurations (AWS, GCP, etc.)

 Common Backend Configurations (S3, DynamoDB for Terraform state locking)

 Reusable IAM Roles, Security Policies, or Defaults




Understanding Each Part
modules/      → Contains Terraform modules for web-tier, app-tier, and db-tier.

Environment/  → Holds environment-specific Terragrunt configs for dev and prod.

Global/       → Stores common settings like the provider, backend, and shared security configurations.

#  Enable Remote State Locking with S3 & DynamoDB

We’ll use an AWS S3 bucket to store Terraform’s state files securely
Setup remote state in root.hcl 

remote_state {

  backend = "s3"

  config = {
    
    bucket         = "my-terraform-state"
    
    key            = "${path_relative_to_include()}/terraform.tfstate"
   
    region         = "us-east-1"
    
    encrypt        = true
    
    dynamodb_table = "terraform-lock"
  }
}


# Improving logging and monitorig
We will implement CloudWatch or any third party monitoring tool of choice
Use Datadog, Prometheus, or AWS X-Ray for deep insights.


# Cost Optimization Strategies

Cut unnecessary expenses and improve efficiency => Use Spot Instances for non-critical workloads

Enable Auto Scaling to prevent resource over-provisioning, Right-size ECS tasks

RDS Cost Optimization => Use Reserved Instances for long-term savings , Enable storage auto-scaling to avoid overprovisioning
Use Multi-AZ only when necessary to reduce costs

Improve Deployment Efficiency => Boost performance and reduce manual errors

Terragrunt Hooks for Pre-Deployment Checks => Prevent bad changes before applying Terraform
terraform {
  before_hook "validate" {

    commands = ["apply"]

    execute  = ["terraform", "validate"]
  }
}


Allow automatic deployments in DEV  while requiring approval for PROD
skip = "${get_env("ENV") == "dev" ? true : false}"


# what does this command do cat /var/log/cloud-init-output.log

Cloud-Init is a tool commonly used in cloud environments (e.g., AWS, Azure, GCP) for bootstrapping and configuring virtual instances when they are launched. It handles tasks like:

Setting up SSH keys.

Installing and configuring software packages.

Running user data scripts.

Debugging Cloud-Init Issues:

If your cloud-init configuration fails, this log file helps you identify errors or missing dependencies.

Verifying Instance Boot Setup:

Ensures user-data scripts ran successfully (e.g., installing software or applying custom configurations).


OPTIONAL => ADDING EC2 IMAGE BUILDER TO FILES


# Reusability Patterns

Terraform modules are self-contained, with variables & outputs for reuse.

Terragrunt separates environment config (inputs) from module logic.

Parent Terragrunt file manages remote state and provider.

Can easily spin up dev/stage/prod environments by changing Terragrunt inputs.

#  Optional Enhancements

Add CI/CD integration (GitHub Actions, Jenkins, CodePipeline)

Add auto-scaling policies for ECS or EC2

Add monitoring & alerts via CloudWatch + SNS

Add Secrets management via AWS Secrets Manager or SSM Parameter Store



# HOW TO FIX ERROR = Missing Environment Variable: The function get_env("AWS_REGION")

1 Check if AWS_REGION is set , run
echo $AWS_REGION

2 If it returns nothing you will need to set it :
export AWS_REGION=us-east-1 

Set it permanently (optional) 
Add the export line to your shell profile (~/.bashrc, ~/.zshrc, etc.) if you want it to persist across sessions.