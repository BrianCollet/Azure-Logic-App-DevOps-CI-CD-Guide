# Azure Logic Apps Standard – CI/CD with Azure DevOps

This repository demonstrates a CI/CD pipeline for deploying an Azure Logic App (Standard) using Azure DevOps.

## Getting Started

1. **Set Up Azure DevOps**: Configure your Azure DevOps project and service connections.
2. **Define Variables**: Update environment-specific variables in the `pipelines/variables` folder.
3. **Run the Pipeline**: Trigger the `deploy.yml` pipeline to provision resources and deploy the Logic App.

## Resources Deployed

- **Logic App**: Azure Logic App (Standard) with workflows.
- **Backend Storage Account**: Hosts Logic App files.
- **Target Storage Account**: Target storage for Logic App operations.
- **App Service Plan**: Hosting plan for the Logic App.
- **API Connections**: Connections for Azure Blob Storage (Managed Identity and Key-based Auth).
- **RBAC Role Assignments**: Permissions for Logic App's Managed Identity.

## Project Structure

```
📁 Workspace/ # Main workspace directory for the project
├── 📁 deployment/ # Contains IaC templates, pipeline definitions, and workflow parameters
│   ├── 📁 infrastructure/ # ARM templates and parameter files for Azure resources
│   │   ├── 📄 azureblob-1.parameters.json # Parameters for Azure Blob Storage (Key-based Auth)
│   │   ├── 📄 azureblob-1.template.json # Template for Azure Blob Storage (Key-based Auth)
│   │   ├── 📄 azureblob.parameters.json # Parameters for Azure Blob Storage (Managed Identity)
│   │   ├── 📄 azureblob.template.json # Template for Azure Blob Storage (Managed Identity)
│   │   ├── 📄 logicapp.parameters.json # Parameters for Logic App deployment
│   │   ├── 📄 logicapp.template.json # Template for Logic App deployment
│   │   ├── 📄 rbac.parameters.json # Parameters for RBAC role assignments
│   │   ├── 📄 rbac.template.json # Template for RBAC role assignments
│   │   ├── 📄 storageaccount.parameters.json # Parameters for Storage Account
│   │   └── 📄 storageaccount.template.json # Template for Storage Account
│   ├── 📁 pipelines/ # Azure DevOps pipeline definitions
│   │   ├── 📄 deploy.yml # CI/CD pipeline for deploying Logic App
│   │   └── 📁 variables/ # Environment-specific variable files
│   │       ├── 📄 dev-variables.yml # Variables for the development environment
│   │       ├── 📄 staging-variables.yml # Variables for the staging environment
│   │       └── 📄 prod-variables.yml # Variables for the production environment
│   └── 📁 workflowparameters/ # Parameters for Logic App workflows
│       └── 📄 parameters.json # Workflow parameters
├── 📁 logicapp/ # Logic App-specific files and configurations
│   ├── 📁 Stateful1/ # Example Logic App workflow
│   │   └── 📄 workflow.json # Workflow definition for Stateful1
```
