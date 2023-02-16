variable "db_username" {
  description = "The username for the database"
  type        = string
  sensitive   = true # indicates the variable contains secrets
}

variable "db_password" {
  description = "The password for the database"
  type        = string
  sensitive   = true
}