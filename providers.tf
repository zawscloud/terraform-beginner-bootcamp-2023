terraform {
#   cloud {
#     organization = "zawscloud-terraform-bootcamp"

#     workspaces {
#       name = "terra-house-1"
#     }
#   }
  required_providers {
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