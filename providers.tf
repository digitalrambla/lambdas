terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }

  }

  required_version = ">= 1.2.0"

  backend "remote" {
        organization = "digitalrambla"

        workspaces {
          name = "apis"
        }
    }
}


provider "aws" {
  region  = var.region
  default_tags {
    tags = var.tags
  }
}

