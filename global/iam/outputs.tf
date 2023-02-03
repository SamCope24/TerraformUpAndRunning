output "all_users" {
  value       = module.users.all_users
  description = "The details for all users"
}

output "all_arns" {
  value       = module.users.all_arns
  description = "The ARNs for all users"
}