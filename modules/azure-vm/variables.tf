variable "resource_group_name" {
  type        = string
  description = "Tên Resource Group lấy từ dự án chính"
}

variable "location" {
  type        = string
  description = "Vùng triển khai (ví dụ: Australia Southeast)"
}

variable "vm_name" {
  type        = string
  description = "Tên của máy ảo"
}

variable "vm_size" {
  type        = string
  default     = "Standard_B2ats_v2"
  description = "Kích thước cấu hình của VM"
}

variable "admin_username" {
  type        = string
  default     = "azureuser"
}

variable "ssh_public_key_path" {
  type        = string
  description = "Đường dẫn đến file .pub hiện đã push lên folder"
}

variable "custom_data_script" {
  type    = string
  default = "" # Nếu không truyền gì thì không cài gì cả
}