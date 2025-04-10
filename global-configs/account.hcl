# locals  for account.hcl
locals {
    default_tags = {}

    aws_account_id       = "345594587109"
    aws_account_name     = "elinks-sandbox"
    aws_iam_assume_role_duration = 3600

    environment  =  "dev"

    remote_state_lock_table = "terragrunt locking"
    remote_state_bucket     = "elinks-terragrunt-demo"
    remote_state_region     = "us-east-1"
}
