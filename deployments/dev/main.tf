
locals {
  company_name = var.company_name
  vpc_name     = "${local.company_name}-vpc"
  common_tags = {
    owner                  = var.company_name
    environment            = local.environment
  }
}



##### VPC #####
data "aws_availability_zones" "available" {
}

module "vpc" {
  source   = "../../core/modules/aws/networking/vpc"
  vpc_name = local.vpc_name
  vpc_tags = local.common_tags

  vpc_availability_zones = data.aws_availability_zones.available.names
}

##### VPC #####
