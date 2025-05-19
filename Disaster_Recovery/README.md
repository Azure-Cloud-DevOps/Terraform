# 1. Create a Recovery Services Vault
      resource "azurerm_recovery_services_vault" "vault" {
        name                = "asr-vault"
        location            = "East US"
        resource_group_name = "my-resource-group"
        sku                 = "Standard"
      }

# 2. Define Site Recovery Fabrics
      resource "azurerm_site_recovery_fabric" "primary" {
        name                = "primary-fabric"
        resource_group_name = "my-resource-group"
        recovery_vault_name = azurerm_recovery_services_vault.vault.name
        location            = "East US"
      }
      
      resource "azurerm_site_recovery_fabric" "secondary" {
        name                = "secondary-fabric"
        resource_group_name = "my-resource-group"
        recovery_vault_name = azurerm_recovery_services_vault.vault.name
        location            = "West US"
      }
# 3. Set Up Protection Containers
      resource "azurerm_site_recovery_protection_container" "primary" {
        name                = "primary-container"
        resource_group_name = "my-resource-group"
        recovery_vault_name = azurerm_recovery_services_vault.vault.name
        recovery_fabric_name = azurerm_site_recovery_fabric.primary.name
      }
      
      resource "azurerm_site_recovery_protection_container" "secondary" {
        name                = "secondary-container"
        resource_group_name = "my-resource-group"
        recovery_vault_name = azurerm_recovery_services_vault.vault.name
        recovery_fabric_name = azurerm_site_recovery_fabric.secondary.name
      }

# 4. Establish Replication Policy
      resource "azurerm_site_recovery_replication_policy" "policy" {
        name                 = "asr-policy"
        resource_group_name  = "my-resource-group"
        recovery_vault_name  = azurerm_recovery_services_vault.vault.name
        recovery_point_retention_in_minutes = 1440
        application_consistent_snapshot_frequency_in_minutes = 60
      }
# 5. Map Protection Containers
      resource "azurerm_site_recovery_protection_container_mapping" "mapping" {
        name                         = "container-mapping"
        resource_group_name          = "my-resource-group"
        recovery_vault_name          = azurerm_recovery_services_vault.vault.name
        recovery_fabric_name         = azurerm_site_recovery_fabric.primary.name
        recovery_container_name      = azurerm_site_recovery_protection_container.primary.name
        target_recovery_fabric_name  = azurerm_site_recovery_fabric.secondary.name
        target_recovery_container_name = azurerm_site_recovery_protection_container.secondary.name
        policy_id                    = azurerm_site_recovery_replication_policy.policy.id
      }
# 6. Configure Replicated VMs
      resource "azurerm_site_recovery_replicated_vm" "replicated_vm" {
        name                         = "replicated-vm"
        resource_group_name          = "my-resource-group"
        recovery_vault_name          = azurerm_recovery_services_vault.vault.name
        source_recovery_fabric_name  = azurerm_site_recovery_fabric.primary.name
        source_recovery_container_name = azurerm_site_recovery_protection_container.primary.name
        target_recovery_fabric_name  = azurerm_site_recovery_fabric.secondary.name
        target_recovery_container_name = azurerm_site_recovery_protection_container.secondary.name
        recovery_replication_policy_id = azurerm_site_recovery_replication_policy.policy.id
        source_vm_id                 = azurerm_virtual_machine.source_vm.id
      }




