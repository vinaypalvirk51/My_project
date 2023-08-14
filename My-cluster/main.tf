resource "azurerm_resource_group" "automate" {
   name = var.resource_group_name
   location = var.location
}

resource "azurerm_kubernetes_cluster""automate" {
    name = var.azure_resource_name
    location = var.location
    resource_group_name = var.resource_group_name
    dns_prefix = "letsautomate"

    default_node_pool {
      name = "default"
      node_count = 1
      vm_size = "Standard_D2_v2"
    }
    identity {
      type = "SystemAssigned"
  }
    depends_on = [azurerm_resource_group.automate]
}