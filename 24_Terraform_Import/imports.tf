✅ Option 1: Automate with a Script (One-by-One Import)
Step 1: Create a file (imports.txt) with your Terraform resource address and Azure resource ID:
## imports.txt
azurerm_resource_group.rg1 /subscriptions/xxxx/resourceGroups/rg1
azurerm_storage_account.storage1 /subscriptions/xxxx/resourceGroups/rg1/providers/Microsoft.Storage/storageAccounts/storage1
azurerm_virtual_network.vnet1 /subscriptions/xxxx/resourceGroups/rg1/providers/Microsoft.Network/virtualNetworks/vnet1

Step 2: Create a Bash script to loop and import:
#!/bin/bash

while IFS= read -r line; do
  echo "Importing: $line"
  terraform import $line
done < imports.txt

✅ Option 2: Use Terraform Import Blocks (Terraform v1.5+)
Step 1: Add import blocks in your .tf file:
import {
  to = azurerm_resource_group.rg1
  id = "/subscriptions/xxxx/resourceGroups/rg1"
}

import {
  to = azurerm_storage_account.storage1
  id = "/subscriptions/xxxx/resourceGroups/rg1/providers/Microsoft.Storage/storageAccounts/storage1"
}

import {
  to = azurerm_virtual_network.vnet1
  id = "/subscriptions/xxxx/resourceGroups/rg1/providers/Microsoft.Network/virtualNetworks/vnet1"
}

Step 2: Run the import:
terraform plan
terraform apply

