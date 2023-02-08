provider "aws" {
  region = "us-east-2"
}

module "users" {
  source     = "../../../modules/landing-zone/iam-user"
  user_names = var.user_names
  give_neo_cloudwatch_full_access = true
}
