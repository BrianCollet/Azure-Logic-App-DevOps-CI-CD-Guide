# Logic App Consumption CICD with Azure DevOps

This repository demonstrates a CI/CD pipeline for deploying a Logic App Consumption workflow using Azure DevOps. It includes ARM templates, parameter files, and a YAML pipeline definition to automate the deployment process.

## Repository Structure

- **logicapp.template.json**: ARM template for deploying the Logic App, including connections and workflow definitions.
- **logicapp.parameters.json**: Parameter file for the Logic App ARM template, specifying deployment-specific values like location, Logic App name, and storage account name.
- **rbac.template.json**: ARM template for assigning RBAC roles to the Logic App's managed identity.
- **rbac.parameters.json**: Parameter file for the RBAC ARM template, specifying the role definition ID and principal ID.
- **pipelines/deploy.yml**: Azure DevOps pipeline definition for validating and deploying the ARM templates.
- **README.md**: Documentation for the repository.

## Deployment Workflow

1. **Logic App Deployment**:

   - Validates and deploys the Logic App ARM template (`logicapp.template.json`) using the parameters in `logicapp.parameters.json`.
   - Outputs the Logic App's trigger URL, tenant ID, and managed identity principal ID.

2. **RBAC Role Assignment**:
   - Deploys the RBAC ARM template (`rbac.template.json`) to assign the specified role to the Logic App's managed identity.
   - Uses the managed identity principal ID from the Logic App deployment outputs.

## Pipeline Parameters

The pipeline accepts the following parameters:

- `serviceConnectionName`: Azure DevOps service connection name for authentication.
- `resourceGroupName`: Name of the Azure resource group for deployment.
- `location`: Azure region for the deployment.
- `logicAppName`: Name of the Logic App to deploy.
- `storageAccountName`: Name of the storage account used in the Logic App.
- `roleDefinitionID`: ID of the RBAC role to assign to the Logic App's managed identity.

## How to Use

1. Update the parameter files (`logicapp.parameters.json` and `rbac.parameters.json`) with your deployment-specific values.
2. Configure the Azure DevOps pipeline using `pipelines/deploy.yml`.
3. Run the pipeline to deploy the Logic App and assign RBAC roles.

## Outputs

The deployment pipeline generates the following outputs:

- Logic App trigger URL
- Tenant ID
- Logic App managed identity principal ID
