terraform {
  required_version = ">= 1.6.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.31"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.20"
    }
    tls = {
      source  = "hashicorp/tls"
      version = ">= 3.4"
    }

  }

  backend "s3" {
    key = "terraform.tfstate"
  }

}


module "aws_provider" {
  source     = "../../core/providers/aws"
  aws_region = var.aws_region
}
