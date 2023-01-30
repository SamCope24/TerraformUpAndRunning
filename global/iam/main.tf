provider "aws" {
  region = "us-east-2"
}

module "users" {
  source = "../../../modules/landing-zone/iam-user"

  count     = length(var.user_names)
  user_name = var.user_names[count.index]
}

variable "user_names" {
  description = "Create IAM users with these names"
  type        = list(string)
  default     = ["neo", "trinity", "morpheus"]
}

output "all_arns" {
  value       = module.users[*].user_arn
  description = "The ARNs for all users"
}