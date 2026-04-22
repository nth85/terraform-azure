# Bên trong modules/azure-vm/outputs.tf
output "public_ip" {
  description = "Địa chỉ IP Public của máy ảo"
  value       = azurerm_public_ip.pip.ip_address
}