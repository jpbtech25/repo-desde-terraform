# terraform {
#   required_version = ">= 1.0.0"

#   backend "s3" {
#     region  = "us-east-1"
#     bucket  = "examplejpb2026-prod-terraform-state"
#     key     = "terraform.tfstate"
#     profile = ""
#     encrypt = "true"

#     dynamodb_table = "examplejpb2026-prod-terraform-state-lock"
#   }
# }
