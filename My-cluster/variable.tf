variable "azure_resource_name" {
  type = string
  description = "Common name for azure resources"
  default = "aks_automate_service"
}

variable "resource_group_name" {
    type = string
    default = "Automate-demo-rg"
}

variable "location" {
    type = string
    default = "eastus"
}


