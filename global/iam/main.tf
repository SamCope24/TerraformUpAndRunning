provider "aws" {
  region = "us-east-2"
}

module "users" {
  source = "../../../modules/landing-zone/iam-user"
  user_names = var.user_names
}

variable "user_names" {
  description = "Create IAM users with these names"
  type        = list(string)
  default     = ["neo", "trinity", "morpheus"]
}

output "all_arns" {
  value       = module.users.all_users
  description = "The ARNs for all users"
}