terraform {
  source = "../../../modules/db-tier"        #"../../modules/db-tier"  TODO
}

include {
  path = find_in_parent_folders("root.hcl")
}

inputs = {
  environment  = "dev"
  db_name      = "dev-db"
  db_engine    = "postgres"
  db_instance_class  = "db.t3.micro"
  db_username  = "admin"
  db_password  = "securepassword"
  db_subnet_ids =["subnet-0f25e0b51c1f49cb9", "subnet-0ff6ef8ee6908b8e3" , "subnet-068ee5276b119b996"]
  tags = {
    Owner       = "Edward"
    Project     = "Three-Tier Web App"
    Environment = "dev"
    CostCenter  = "Development"
  }
}