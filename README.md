# Azure Logic Apps – CI/CD with Azure DevOps

This repository demonstrates best practices for implementing CI/CD pipelines to deploy Azure Logic Apps using Azure DevOps. It includes examples for both Standard and Consumption Logic Apps, along with infrastructure-as-code (IaC) templates and pipeline definitions.

## Getting Started

1. **Set Up Azure DevOps**: Configure your Azure DevOps project and service connections.
2. **Choose a Deployment Model**: Select either the Standard or Consumption Logic App model based on your requirements.
3. **Define Variables**: Update environment-specific variables in the parameter files.
4. **Run the Pipeline**: Trigger the appropriate pipeline to provision resources and deploy the Logic App.

## Don't Know Where to Start?

I recommend starting with the [Basic-Demo in Standard](./Standard/Basic-Demo/README.md). This example provides a simple and clear introduction to deploying Azure Logic Apps (Standard) using CI/CD pipelines.

## Repository Structure

```
Standard/                         # Azure Logic Apps Standard scenarios
├── Basic-Demo/
│   ├── ARM/                       # ARM templates, parameters, and pipeline
│   ├── logicapp/                  # Shared Logic App source
│   └── README.md
└── Private-Storage/               # Standard Logic App with private storage
    ├── Terraform/                 # Terraform IaC implementation
    ├── ARM/                       # Future ARM templates and pipeline
    └── README.md

Consumption/                      # Azure Logic Apps Consumption scenarios
└── Basic-Demo/
	├── ARM/                       # ARM templates, parameters, and pipeline
	└── README.md
```

## Key Features

- **Standard and Consumption Models**: Examples for both Logic App deployment models.
- **Infrastructure as Code (IaC)**: ARM templates and Terraform implementations for flexible deployment options.
- **CI/CD Pipelines**: Azure DevOps pipelines for automating deployments.
- **Environment-Specific Configurations**: Parameter files for development, staging, and production environments.
- **Private Storage Support**: Terraform implementation for Standard Logic Apps with private endpoints and secure networking.

## Resources Deployed

- **Logic Apps**: Azure Logic Apps (Standard and Consumption) with workflows.
- **Storage Accounts**: For Logic App operations and private storage.
- **App Service Plans**: Hosting plans for Standard Logic Apps.
- **RBAC Role Assignments**: Permissions for Logic App's Managed Identity.
- **Private Endpoints**: Secure connections for private storage (Standard Logic Apps).

## Contributing

Contributions are welcome! Please submit a pull request or open an issue to discuss changes.

## License

This project is licensed under the MIT License. See the LICENSE file for details.
