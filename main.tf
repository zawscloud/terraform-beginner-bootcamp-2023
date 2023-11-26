terraform {
  required_providers {
    terratowns = {
      source = "local.providers/local/terratowns"
      version = "1.0.0"
    }
  }
  #   cloud {
  #     organization = "zawscloud-terraform-bootcamp"

  #     workspaces {
  #       name = "terra-house-1"
  #     }
  #   }

}
provider "terratowns" {
  endpoint = var.terratowns_endpoint
  user_uuid = var.teacherseat_user_uuid //"b3b3c3d1-323d-4bf4-9ddb-00d852e1d4a6"
  token = var.terratowns_access_token
}
module "terrahouse_aws" {
  source              = "./modules/terrahouse_aws"
  user_uuid           = var.teacherseat_user_uuid 
  index_html_filepath = var.index_html_filepath
  error_html_filepath = var.error_html_filepath
  content_version     = var.content_version
  assets_path = var.assets_path
}

resource "terratowns_home" "home" {
  name = "How to play Arcunum in 2023! to 2024!"
  description = <<DESCRIPTION
Arcanum is a game from 2001 that shipped with alot of bugs.
Modders have removed all the originals making this game really fun to play
(despite the old looking graphics). This is my guide that will show you how to play
arcanum without spoiling the plot
  DESCRIPTION
  domain_name = module.terrahouse_aws.cloudfront_url
  #domain_name = "3fdighz.cloudfront.net"
  town = "missingo"
  content_version = 1
}