variable "location" {
  type    = string
  default = "westus"
}

variable "resource_group_name" {
  type    = string
  default = "logic-app-private-storage-rg"
}

variable "virtual_network_name" {
  type    = string
  default = "logic-app-private-storage-vnet"
}

variable "storage_account_name" {
  type    = string
  default = "brlapssa91264"
}

variable "file_share_name" {
  type    = string
  default = "logicapp-content"
}

variable "app_service_plan_name" {
  type    = string
  default = "logic-app-private-storage-asp-4"
}

variable "logic_app_name" {
  type    = string
  default = "brlapsla91264"
}
