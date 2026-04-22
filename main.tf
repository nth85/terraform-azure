locals {
  # 1. Định nghĩa bảng tra cứu cho từng môi trường
  env_configs = {
    "dev" = {
      name  = "development"
      count = 1
      size  = "Standard_B1s"
    }
    "staging" = {
      name  = "staging"
      count = 1
      size  = "Standard_B2ats_v2"
    }
    "prod" = {
      name  = "production"
      count = 2
      size  = "Standard_B2ats_v2"
    }
  }
  # 2. Trích xuất cấu hình dựa trên Workspace hiện tại
  # Nếu workspace không có trong bảng trên, có thể dùng hàm lookup để đặt giá trị mặc định
  current_config = lookup(local.env_configs, terraform.workspace, local.env_configs["dev"])

  # 3. Gán lại các biến để dùng cho code bên dưới
  env_name = local.current_config.name
  vm_count = local.current_config.count
  vm_size  = local.current_config.size
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-${local.env_name}"
  location = "australiasoutheast"
}

module "web_server" {
  source              = "./modules/azure-vm"
  count               = local.vm_count 
  
  vm_name             = "vm-web-${local.env_name}-${count.index}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  vm_size             = local.vm_size
  ssh_public_key_path = var.ssh_key_local
}

#####################################################################
# locals {
#   # Nếu workspace là prod thì env là "production", ngược lại là "development"
#   env_name = terraform.workspace == "prod" ? "production" : "development"
  
#   # Nếu là prod thì tạo 2 máy, dev chỉ tạo 1 máy để tiết kiệm
#   vm_count = terraform.workspace == "prod" ? 2 : 1
  
#   # Chọn size máy dựa trên môi trường
# #  vm_size  = terraform.workspace == "prod" ? "Standard_B2ats_v2" : "Standard_B2ats_v2"
# }

# resource "azurerm_resource_group" "rg" {
#   name     = "rg-${local.env_name}"
#   location = "australiasoutheast"
# }

# module "web_server" {
#   source              = "./modules/azure-vm"
#   # Dùng vòng lặp count để tạo số lượng máy theo môi trường
#   count               = local.vm_count 
#   vm_name             = "vm-web-${local.env_name}-${count.index}"
#   resource_group_name = azurerm_resource_group.rg.name
#   location            = azurerm_resource_group.rg.location
#   vm_size             = var.instance_size[terraform.workspace]
#   ssh_public_key_path = var.ssh_key_local
# }

#####################################################################
# # Tạo Resource Group chung cho cả dự án
# resource "azurerm_resource_group" "main" {
#   name     = var.main_rg_name
#   location = var.main_location
# }

# # Gọi Module lần 1 (Máy Web)
# module "web_server" {
#   source              = "./modules/azure-vm"
  
#   # Truyền giá trị từ biến bên ngoài và từ RG vừa tạo vào Module
#   resource_group_name = azurerm_resource_group.main.name
#   location            = azurerm_resource_group.main.location
#   vm_name             = "vm-web-dev"
#   vm_size             = "Standard_B2ats_v2"
#   ssh_public_key_path = var.ssh_key_local
#   custom_data_script = <<-EOF
# #!/bin/bash
# apt-get update -y
# apt-get install -y docker.io
# systemctl start docker
# # Chạy Nginx cho máy Web
# docker run -d -p 80:80 --name web-server nginx
# EOF
# }

# # Gọi Module lần 2 (Máy Database - nếu cần)
# module "db_server" {
#   source              = "./modules/azure-vm"
  
#   resource_group_name = azurerm_resource_group.main.name
#   location            = azurerm_resource_group.main.location
#   vm_name             = "vm-db-dev"
#   vm_size             = "Standard_B2ats_v2"
#   ssh_public_key_path = var.ssh_key_local
#   custom_data_script = <<-EOF
# #!/bin/bash
# apt-get update -y
# apt-get install -y docker.io
# systemctl start docker
# # Chạy MariaDB cho máy DB
# docker run -d --name db-server -e MARIADB_ROOT_PASSWORD=dbtest2010 -p 3306:3306 mariadb
# EOF
# }
