terraform {
  required_providers {
    terratowns = {
      source = "local.providers/local/terratowns"
      version = "1.0.0"
    }
  }
    # backend "remote" {
    # hostname     = "app.terraform.io"
    # organization = "zawscloud-terraform-bootcamp"
    cloud {
      organization = "zawscloud-terraform-bootcamp"

      workspaces {
        name = "terra-house-1"
      }
    }

}
provider "terratowns" {
  endpoint = var.terratowns_endpoint
  user_uuid = var.teacherseat_user_uuid 
  token = var.terratowns_access_token
}
module "home_arcanum_hosting" {
  source              = "./modules/terrahome_aws"
  user_uuid           = var.teacherseat_user_uuid 
  public_path = var.arcanum.public_path
  content_version     = var.arcanum.content_version

}

resource "terratowns_home" "home_arcanum" {
  name = "How to play Aracunum in 2023! to 2024!"
  description = <<DESCRIPTION
Arcanum is a game from 2001 that shipped with alot of bugs.
Modders have removed all the originals making this game really fun to play
(despite the old looking graphics). This is my guide that will show you how to play
arcanum without spoiling the plot
  DESCRIPTION
  domain_name = module.home_arcanum_hosting.domain_name
  town = "missingo"
  content_version = var.arcanum.content_version
}


module "home_payday_hosting" {
  source              = "./modules/terrahome_aws"
  user_uuid           = var.teacherseat_user_uuid
  public_path = var.payday.public_path
  content_version     = var.payday.content_version

}


resource "terratowns_home" "home_payday" {
  name = "Making your Payday Bar"
  description = <<DESCRIPTION
  Thanks for Visiting. Payday Bar Page is Currently Work in Progress. Updates Coming Soon! Thanks
  DESCRIPTION
  domain_name = module.home_payday_hosting.domain_name
  town = "missingo"
  content_version = var.payday.content_version
}