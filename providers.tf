terraform {
#   cloud {
#     organization = "zawscloud-terraform-bootcamp"

#     workspaces {
#       name = "terra-house-1"
#     }
#   }
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "3.5.1"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "5.18.1"
    }
  }
}

provider "aws" { 
}

provider "random" {
  # Configuration options
}