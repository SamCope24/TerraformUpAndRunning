output "address" {
  value = module.db.address
  description = "Connect to the database at this endpoint"
}

output "port" {
  value = module.db.port
  description = "The port the database is listening on"
}