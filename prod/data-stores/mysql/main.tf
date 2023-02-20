provider "aws" {
  region = "us-east-2"
}

module "db" {
    source = "../../../../modules/data-stores/mysql"
    db_name = "production_db"
}

# configure terraform to store state in an S3 bucket
terraform {
  backend "s3" {
    bucket = "terraform-up-and-running-state-5829cbe9"
    key    = "prod/data-stores/mysql/terraform.tfstate"
    region = "us-east-2"

    dynamodb_table = "terraform-up-and-running-locks"
    encrypt        = true
  }
}