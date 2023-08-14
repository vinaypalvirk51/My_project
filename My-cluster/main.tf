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
module "keyvault" {
  source              = "../modules"
  name                = var.keyvault_name
  resource_group_name = azurerm_resource_group.automate.name
  location            = var.location

  access_policies = [
    {
      object_id               = "bf0972a7-0702-4102-8644-e1fb0578bde0" // my-user-objectid # find it in the active directory
      certificate_permissions = ["Get"]
      key_permissions         = ["Get", "List"]
      secret_permissions      = ["Get", "List", "Set"]
      storage_permissions     = []
    },
    {
      object_id               =  azurerm_kubernetes_cluster.automate.kubelet_identity[0].object_id // kubelet identity
      certificate_permissions = ["Get"]
      key_permissions         = ["Get", "List"]
      secret_permissions      = ["Get", "List"]
      storage_permissions     = []
    }
  ]
}