terraform {
  required_providers {
    # random = {
    #   source  = "hashicorp/random"
    #   version = "3.5.1"
    # }
    aws = {
      source  = "hashicorp/aws"
      version = "5.16.2"
    }
  }
  # cloud {
  #   organization = "bootcamp-demox"

  #   workspaces {
  #      name = "Terra-house-1"
  #   }
  # }
}

provider "aws" {
  # Configuration options
}
provider "random" {
  # Configuration options
}