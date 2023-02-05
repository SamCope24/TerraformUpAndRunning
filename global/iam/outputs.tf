output "all_users" {
  value       = module.users.all_users
  description = "The details for all users"
}

output "all_arns" {
  value       = module.users.all_arns
  description = "The ARNs for all users"
}

output "upper_names" {
  value = [for name in var.user_names : upper(name) if length(name) < 5]
}

output "bios" {
  value = [for name, role in var.hero_thousand_faces : "${name} is the ${role}"]
}

output "upper_roles" {
  value = {for name, role in var.hero_thousand_faces : upper(name) => upper(role)}
}