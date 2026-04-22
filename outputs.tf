# Bên ngoài outputs.tf

output "web_public_ip" {
  value = module.web_server[*].public_ip
}

# output "db_public_ip" {
#   value = module.db_server.public_ip
# }