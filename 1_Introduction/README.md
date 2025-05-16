# Get yourself familiarized with Terraform documentation
  https://registry.terraform.io/providers/hashicorp/azurerm/latest
# Create the below Azure resources using azurerm Terraform provider
  - Resource Group
  - Storage account

# Login to Azure
  >> az login

# Create Service principal
  >> az ad sp create-for-rbac -n az-demo --role="Contributor" --scopes="/subscriptions/$SUBSCRIPTION_ID"
# Set env vars so that the service principal is used for authentication
  export ARM_CLIENT_ID=""
  export ARM_CLIENT_SECRET=""
  export ARM_SUBSCRIPTION_ID=""
  export ARM_TENANT_ID=""
