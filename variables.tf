variable "main_rg_name" {
  type    = string
  default = "rg-terraform-modules"
}

variable "main_location" {
  type    = string
  default = "Australia Southeast"
}


variable "ssh_key_local" {
  type    = string
  default = "./vm01_key.pub" #"D:/1.1Huynt/GIT/cloudoffline/azure/vm01_key.pub"
}

variable "is_prod" {
  type    = bool
  default = false
}

variable "instance_size" {
  type = map(string)
  default = {
    "dev"     = "Standard_B1s"
    "prod"    = "Standard_B2ats_v2"
    "staging" = "Standard_B2ats_v2"
  }
}