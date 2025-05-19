## Hasihorp
   - HashiCorp Terraform is an infrastructure as code tool that lets you define both cloud and on-prem resources in human-readable configuration files that you can version reuse and share.
   - Through Terraform work-flow we can easily provision and manage all of your infrastructure throughout its lifecycle.
   - Through Terraform we can manage low-level components like compute, storage and networking resources, as well as high-level components like DNS entries and SaaS features.
## Terraform
   - Terraform is an open-source infrastructure as code (IaC) tool developed by HashiCorp that allows users to define and provision data center infrastructure using a high-level configuration language called HCL (HashiCorp Configuration Language) or JSON.

## Summary of Categories:
  # Infrastructure as Code (IaC): 
    Terraform, CloudFormation, Pulumi, Google Cloud Deployment Manager, ARM Templates.
  # Configuration Management: 
    Ansible, Chef, Puppet, SaltStack.
  # Container Orchestration: 
    Kubernetes, Helm, Rancher.
  # Virtualization & Development Environments: 
    Vagrant.
  # Multi-Cloud Management: 
    CloudBolt.

## Basic Workflow:
  1) Write Configuration: Define your infrastructure in .tf files.
  2) Initialize Terraform: Use terraform init to initialize the working directory and download the necessary provider plugins.
                           Provider file help you to connect cloud services. These are binaries
  4)  Plan: Run terraform plan to see what changes will be made based on the current configuration.
  5)  Apply: Execute terraform apply to apply the changes and provision resources.
  6)  Destroy: When no longer needed, you can run terraform destroy to clean up and delete the infrastructure.

![image](https://github.com/user-attachments/assets/6e140a33-f55b-45bb-ac62-6dc378168e64)

![image](https://github.com/user-attachments/assets/5d37d132-9e7f-4981-a8fb-6883264e7f7f)

## Terraform.tfvars
    -It stores variable values
    -Terraform.tfvars are local configuration files    
    -Terraform.tfvars is sourced automatically by Terraform at runtime
    -Variables in Terraform.tfvars are only valid for that particular environment
    -Terraform.tfvars provides default values for the variables declared in variables.tf

## variables.tf
    -It stores variable definitions such as data type and possible values
    -variables.tf files are used to define variables in multiple environment
    -variables.tf must be specified explicitly when running Terraform commands
    -variables in variables.tf can be used across environments when defined properly
    -variables.tf do not provide any default values


## Common Azure Resources Deployed with Terraform for Azure OpenAI
# Core Azure OpenAI Resources
  1. azurerm_cognitive_account
  2. azurerm_cognitive_deployment
# Supporting Azure Resources
  1. azurerm_resource_group
  2. azurerm_virtual_network
  3. azurerm_subnet
  4. azurerm_private_endpoint
  5. azurerm_key_vault
  6. azurerm_storage_account
  7. azurerm_monitor_diagnostic_setting
  8. azurerm_kubernetes_cluster
  9. azurerm_application_gateway
 10. azurerm_log_analytics_workspace
 11. azurerm_role_assignment
 12. azurerm_user_assigned_identity
 13. azurerm_network_interface
 14. azurerm_network_security_group
 15. azurerm_public_ip
 16. azurerm_dns_zone

# Folder Strucutre
      azure-terraform-project/
      ├── modules/                        # Reusable child modules
      │   ├── resource_group/             # Child module for Azure Resource Groups
      │   │   ├── main.tf
      │   │   ├── variables.tf
      │   │   ├── outputs.tf
      │   │   └── README.md
      │   ├── virtual_network/            # Child module for Azure Virtual Networks
      │   │   ├── main.tf
      │   │   ├── variables.tf
      │   │   ├── outputs.tf
      │   │   └── README.md
      │   ├── network_security_group/     # Child module for NSGs
      │   │   ├── main.tf
      │   │   ├── variables.tf
      │   │   ├── outputs.tf
      │   │   └── README.md
      │   └── ...
      ├── environments/                   # Root modules for different environments
      │   ├── dev/                        # Root module for Development environment
      │   │   ├── main.tf
      │   │   ├── variables.tf
      │   │   ├── terraform.tfvars
      │   │   └── backend.tf
      │   ├── staging/                    # Root module for Staging environment
      │   │   ├── main.tf
      │   │   ├── variables.tf
      │   │   ├── terraform.tfvars
      │   │   └── backend.tf
      │   └── prod/                       # Root module for Production environment
      │       ├── main.tf
      │       ├── variables.tf
      │       ├── terraform.tfvars
      │       └── backend.tf
      ├── scripts/                        # Helper scripts
      │   └── deploy.sh
      ├── .gitignore
      └── README.md

