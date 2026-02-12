terraform {
  required_providers {
  aws = {
      source  = "hashicorp/aws"
      version = ">=6.20.0, <6.27.0, !=6.23.0"
    }
  github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }
  required_version = "~>1.14.0"
}

provider "aws" {
  region = "us-east-1"
  access_key = var.access key
  secret_key = var.secret key
  default_tags {
    tags = var.tags
  }
}
provider "github" {
  # Es mejor usar variables de entorno, pero aquí va la estructura:
  token = var.github_token 
  owner = "jpbtech25"
}
