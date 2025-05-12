
## what are things mostly we will create using Terraform for Azure CLoud?
1. Compute Resources
  •	Virtual Machines (VMs): Provision and manage Windows/Linux virtual machines.
    o	Example: azurerm_linux_virtual_machine, azurerm_windows_virtual_machine
  •	Virtual Machine Scale Sets (VMSS): Automate scaling of VM instances.
    o	Example: azurerm_virtual_machine_scale_set
  •	Azure Kubernetes Service (AKS): Set up and manage Kubernetes clusters for containerized applications.
    o	Example: azurerm_kubernetes_cluster
  •	Azure Functions: Deploy serverless functions for event-driven applications.
    o	Example: azurerm_function_app
  •	App Service Plan: Configure the infrastructure for hosting web applications or APIs.
    o	Example: azurerm_app_service_plan
  •	App Service: Deploy and manage web apps, APIs, or mobile backends.
    o	Example: azurerm_app_service
2. Networking
  •	Virtual Networks (VNets): Configure and manage networking in Azure.
    o	Example: azurerm_virtual_network
  •	Subnets: Subdivide VNets into smaller segments for isolation.
    o	Example: azurerm_subnet
  •	Network Security Groups (NSGs): Define inbound and outbound traffic rules to secure your network.
    o	Example: azurerm_network_security_group
  •	Load Balancers: Distribute traffic across multiple instances for high availability.
    o	Example: azurerm_lb
  •	Azure Application Gateway: Manage application-level traffic with advanced routing.
    o	Example: azurerm_application_gateway
  •	Azure VPN Gateway: Set up VPN connections between on-premises and Azure networks.
    o	Example: azurerm_virtual_network_gateway
  •	Azure ExpressRoute: Establish private, dedicated network connections from on-premises to Azure.
    o	Example: azurerm_express_route_circuit
  •	Azure Firewall: Secure your network by filtering traffic and preventing unauthorized access.
    o	Example: azurerm_firewall
3. Storage
  •	Azure Storage Accounts: Set up blob, file, queue, and table storage for your applications.
    o	Example: azurerm_storage_account
  •	Blob Storage: Manage unstructured data such as images, videos, and backups.
    o	Example: azurerm_storage_container
  •	Azure Files: Manage shared file systems accessible from multiple machines.
    o	Example: azurerm_storage_share
  •	Azure Disk Storage: Attach persistent disks to your VMs for additional storage.
    o	Example: azurerm_managed_disk
4. Databases
  •	Azure SQL Database: Deploy and manage SQL databases in Azure.
    o	Example: azurerm_sql_database
  •	Azure Cosmos DB: A globally distributed, multi-model database service.
    o	Example: azurerm_cosmosdb_account
  •	Azure Database for PostgreSQL/MySQL: Provision managed PostgreSQL or MySQL databases.
    o	Example: azurerm_postgresql_server, azurerm_mysql_server
  •	Azure Redis Cache: Set up an in-memory data store for caching.
    o	Example: azurerm_redis_cache
5. Identity & Access Management
  •	Azure Active Directory (AAD): Manage users, groups, and applications in Azure AD.
    o	Example: azurerm_azuread_application, azurerm_azuread_service_principal
  •	Service Principals: Securely manage application identities and access.
    o	Example: azurerm_azuread_service_principal
  •	Role-Based Access Control (RBAC): Set permissions for Azure resources.
    o	Example: azurerm_role_assignment
  •	Managed Identity: Use managed identities to grant Azure resources access to other Azure services.
    o	Example: azurerm_user_assigned_identity
6. Security
  •	Key Vault: Securely store and manage keys, secrets, and certificates.
    o	Example: azurerm_key_vault
  •	Azure Security Center: Enable security policies, threat protection, and compliance monitoring.
    o	Example: azurerm_security_center_contact
  •	Azure Policy: Implement governance and compliance policies for your resources.
    o	Example: azurerm_policy_definition, azurerm_policy_assignment
7. Monitoring & Logging
  •	Azure Monitor: Set up monitoring for infrastructure and applications.
    o	Example: azurerm_monitor_diagnostic_setting
  •	Log Analytics Workspace: Centralized logging and analysis of Azure resources.
    o	Example: azurerm_log_analytics_workspace
  •	Azure Application Insights: Monitor application performance and troubleshoot issues.
    o	Example: azurerm_application_insights
8. Resource Management
  •	Resource Groups: Organize and manage your Azure resources in groups.
    o	Example: azurerm_resource_group
  •	Tags: Add tags to resources for better organization and cost management.
    o	Example: azurerm_tags
9. Compliance and Governance
  •	Azure Blueprints: Define and manage your organization’s infrastructure in a repeatable manner.
    o	Example: azurerm_blueprint_definition, azurerm_blueprint_assignment
  •	Azure Management Groups: Organize your Azure subscriptions for governance and policy application.
    o	Example: azurerm_management_group
  •	Azure Cost Management: Set budgets, track spending, and optimize costs.
    o	Example: azurerm_cost_management_budget
10. Automation
  •	Automation Accounts: Use for automating configuration management tasks.
    o	Example: azurerm_automation_account
  •	Runbooks: Automate operational tasks with Azure Automation Runbooks.
    o	Example: azurerm_automation_runbook
11. DevOps and CI/CD Integration
  •	Azure DevOps Pipelines: Integrate with Terraform to automate infrastructure provisioning within CI/CD pipelines.
    o	Example: You can trigger terraform apply commands in Azure DevOps pipelines to deploy infrastructure.
  •	Azure Container Registry: Store and manage Docker container images.
    o	Example: azurerm_container_registry
  •	Azure Container Instances (ACI): Run containers in Azure without managing VMs.
    o	Example: azurerm_container_group

## what are things mostly we will create using Terraform for Azure DevOps?
1. Azure Resources
  •	Virtual Machines (VMs): Provisioning and managing Linux/Windows VMs in Azure.
  •	Azure Kubernetes Service (AKS): Setting up and managing AKS clusters for containerized workloads.
  •	App Services: Creating and managing web apps or API apps using Azure App Service.
  •	Storage Accounts: Setting up Azure Storage Accounts, Blobs, Queues, and File shares.
  •	Azure SQL Database: Creating and managing Azure SQL Databases or SQL Servers.
  •	Networking Resources: Setting up Virtual Networks, Subnets, Network Security Groups (NSGs), Load Balancers, Application Gateways, VPNs, and ExpressRoute connections.
  •	Azure Functions: Deploying and managing Azure Functions for serverless applications.
  •	Key Vault: Managing secrets, keys, and certificates securely.
  •	Azure Container Instances (ACI): Running containers directly in Azure without the need for VMs.
  •	Resource Groups: Managing resource groups that organize your Azure resources.
2. Azure DevOps Resources
  •	Azure DevOps Pipelines: Automating the creation of CI/CD pipelines.
  •	Service Connections: Creating and managing service connections for Azure to facilitate secure interactions between Azure DevOps and Azure.
  •	Azure Repos: Managing and configuring Azure Repos (repositories) to host source code.
  •	Azure DevOps Projects: Setting up and managing Azure DevOps Projects to organize teams and resources.
  •	Azure DevOps Variables: Defining and managing pipeline variables to streamline deployment and configuration.
3. Infrastructure as Code (IaC)
  •	Modules: Reusable Terraform modules for common infrastructure patterns (e.g., networking, compute, or storage).
  •	State Management: Managing Terraform state files (local or remote backends like Azure Storage) to ensure consistency and track infrastructure changes.
  •	Provisioning Resources: Managing resource lifecycle (creation, modification, and destruction) based on configuration files.
  •	Secrets Management: Using Azure Key Vault in combination with Terraform to securely manage sensitive data during deployments.
4. Monitoring and Logging
  •	Azure Monitor: Setting up monitoring resources like Log Analytics, Application Insights, and monitoring alerts.
  •	Azure Log Analytics Workspace: Managing log analytics workspaces to collect and analyze log data from your Azure resources.
5. Access Management
  •	Azure Active Directory (AAD): Managing identities, role-based access control (RBAC), and service principals.
  •	Managed Identities: Enabling Managed Identities for Azure services to avoid managing credentials directly.
6. CI/CD Pipeline Infrastructure
  •	Pipeline Triggers: Defining automatic triggers (like Git push or pull requests) to initiate Terraform-based deployments.
  •	Terraform Plan & Apply: Automating the execution of terraform plan (for previewing changes) and terraform apply (for applying changes to Azure infrastructure).
  •	Workspace Management: Managing different workspaces for different environments (development, staging, production) in Azure DevOps.
7. Scaling and Load Balancing
  •	Virtual Machine Scale Sets (VMSS): Auto-scaling VMs in response to demand.
  •	Azure Load Balancer: Distributing traffic across multiple VMs or services for high availability.
8. Security & Compliance
  •	Azure Security Center: Configuring security policies and monitoring the security posture of resources.
  •	Policy as Code: Implementing Azure Policy and governance controls via Terraform.
  •	Azure Firewall and NSG Policies: Configuring network security rules for secure communication.
