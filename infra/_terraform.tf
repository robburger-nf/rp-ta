###################
# Terraform & State
###################
terraform {
  required_version = "~> 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "robburger-nf"

    workspaces {
      name = "rp-ta"
    }
  }
}
