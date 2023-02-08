output "all_users" {
  value       = module.users.all_users
  description = "The details for all users"
}

output "all_arns" {
  value       = module.users.all_arns
  description = "The ARNs for all users"
}

output "neo_cloudwatch_policy_arn" {
  value = module.users.neo_cloudwatch_policy_arn
  description = "The arn of the cloudwatch policy attached to neo"
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

output "for_directive" {
  value = "%{ for name in var.user_names }${name}, %{ endfor }"
}

output "for_directive_index" {
  value = "%{ for i, name in var.user_names }(${i}) ${name}, %{ endfor }"
}