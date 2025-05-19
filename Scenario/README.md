# 🏗️ Challenges When Creating Azure Infrastructure Using Terraform – with Code
# 1. Resource Dependency Management
Scenario: VM created before subnet was ready.
Code Example:
        resource "azurerm_virtual_network" "vnet" {
          name                = "my-vnet"
          address_space       = ["10.0.0.0/16"]
          location            = azurerm_resource_group.rg.location
          resource_group_name = azurerm_resource_group.rg.name
        }
        
        resource "azurerm_subnet" "subnet" {
          name                 = "my-subnet"
          resource_group_name  = azurerm_resource_group.rg.name
          virtual_network_name = azurerm_virtual_network.vnet.name
          address_prefixes     = ["10.0.1.0/24"]
        }
        
        resource "azurerm_network_interface" "nic" {
          name                = "my-nic"
          location            = azurerm_resource_group.rg.location
          resource_group_name = azurerm_resource_group.rg.name
        
          ip_configuration {
            name                          = "internal"
            subnet_id                     = azurerm_subnet.subnet.id
            private_ip_address_allocation = "Dynamic"
          }
        }
        
        resource "azurerm_linux_virtual_machine" "vm" {
          name                  = "my-vm"
          location              = azurerm_resource_group.rg.location
          resource_group_name   = azurerm_resource_group.rg.name
          size                  = "Standard_B1s"
          admin_username        = "azureuser"
          network_interface_ids = [azurerm_network_interface.nic.id]
          depends_on            = [azurerm_subnet.subnet]
        
          admin_ssh_key {
            username   = "azureuser"
            public_key = file("~/.ssh/id_rsa.pub")
          }
        
          os_disk {
            caching              = "ReadWrite"
            storage_account_type = "Standard_LRS"
          }
        
          source_image_reference {
            publisher = "Canonical"
            offer     = "UbuntuServer"
            sku       = "18.04-LTS"
            version   = "latest"
          }
        }

# 2. State File Management:
Code Example – backend block in main.tf:
        terraform {
          backend "azurerm" {
            resource_group_name  = "tfstate-rg"
            storage_account_name = "tfstatestorage123"
            container_name       = "tfstate"
            key                  = "prod.terraform.tfstate"
          }
        }
  # 3. Handling Secrets Securely
  client_secret = "hardcoded_secret"
        
        data "azurerm_key_vault" "kv" {
          name                = "my-keyvault"
          resource_group_name = "my-rg"
        }
        
        data "azurerm_key_vault_secret" "client_secret" {
          name         = "terraform-client-secret"
          key_vault_id = data.azurerm_key_vault.kv.id
        }
        
        provider "azurerm" {
          features {}
        
          client_id       = var.client_id
          client_secret   = data.azurerm_key_vault_secret.client_secret.value
          tenant_id       = var.tenant_id
          subscription_id = var.subscription_id
        }

# 4. Terraform Provider or API Version Changes
      terraform {
        required_providers {
          azurerm = {
            source  = "hashicorp/azurerm"
            version = "~> 3.64.0"
          }
        }
      
        required_version = ">= 1.3.0"
      }
*****************************************************************************************************************
# 🚀 Challenges in Azure DevOps Pipelines – with Code Examples
# 1. Service Connection and Permission Issues
    az role assignment create \
      --assignee "<SPN-Client-ID>" \
      --role "Contributor" \
      --scope "/subscriptions/<sub-id>/resourceGroups/<rg-name>"
# 2. Pipeline Secrets Not Passed Properly
    variables:
      - group: terraform-secrets
    
    steps:
      - script: |
          echo "Client Secret: $(client_secret)"
        displayName: "Show Secret"
# 3. Pipeline Approval & Manual Intervention
    stages:
      - stage: Plan
        jobs:
          - job: TerraformPlan
            steps:
              - script: terraform plan
                displayName: Terraform Plan
    
      - stage: Apply
        dependsOn: Plan
        environment: 'Prod'  # Manual approval enabled in Azure DevOps UI
        jobs:
          - job: TerraformApply
            steps:
              - script: terraform apply -auto-approve

# 4. Handling Terraform State in Pipeline
      steps:
        - script: terraform plan -out=tfplan
          displayName: Terraform Plan
      
        - publish: tfplan
          artifact: terraformPlan
  
        - download: current
          artifact: terraformPlan
        
        - script: terraform apply tfplan
          displayName: Terraform Apply
# 5. Long Execution Times or Timeouts
      jobs:
        - job: LongJob
          timeoutInMinutes: 90
          steps:
            - script: terraform apply -auto-approve
            
  terraform apply -target=module.network
  terraform apply -target=module.vm
*********************************************************************************



