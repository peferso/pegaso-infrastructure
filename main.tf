# ================================================================================ #
#                       main.tf file of: root Module 
#   This template creates:
#              1. Security groups used by 2 EC2 instances.
#              2. An EC2 instance configured to act as a MySQL server.
# -------------------------------------------------------------------------------- #
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      #version = "~> 2.70"
      version = "~> 4.2.0"
    }
  }
}

provider "aws" {
  region  = var.my_region
  access_key = var.my_public_key
  secret_key = var.my_secret_key
}

module "SecurityGroups" {
  source = "./Modules/SecurityGroups"
}

module "EC2Database" {
  source = "./Modules/EC2Database"
  number_of_environments = var.number_of_environments
  ec2SubNt = var.my_subnet_1
  secGrpID = module.SecurityGroups.serverEC2SecGrID
  environmentName = var.environmentName
}
  
module "EC2Vanilla" {
  source = "./Modules/EC2Vanilla"
  number_of_environments = 1
  ec2SubNt = var.my_subnet_1
  secGrpID = module.SecurityGroups.clientEC2SecGrID
  environmentName = var.environmentName
  iam_ec2_profile_name = module.roles.iam_ec2_profile_name
}

module "roles" {
  source = "./Modules/IAM"
  ec2_event_bus_arn = module.events.ec2_manager_bus_arn
  bucket_arn = module.s3_bucket.bucket_arn
}

module "events" {
  source = "./Modules/Events"
}

module "s3_bucket" {
  source = "./Modules/S3"
}

