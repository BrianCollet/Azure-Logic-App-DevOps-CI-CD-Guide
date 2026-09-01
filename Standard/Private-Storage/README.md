# Azure Logic Apps Standard - Private Storage

This scenario demonstrates a Standard Logic App deployed with private storage, including secure blob storage access patterns and networking configurations.

## Implementation

### Terraform
A complete Terraform implementation is provided for deploying a Standard Logic App with private storage infrastructure. This includes:
- Storage account configuration with private endpoints
- Standard Logic App deployment with managed identity authentication
- Networking setup for private connectivity
- Variable definitions for environment-specific deployments

```
Private-Storage/
├── Terraform/
│   ├── main.tf          # Primary resource definitions
│   ├── variables.tf     # Input variable declarations
│   └── locals.tf        # Local value computations
├── ARM/                 # Future ARM templates, parameters, and pipeline
└── Bicep/               # Future Bicep implementation
```

### Future Implementations
ARM and Bicep implementations are planned for additional Infrastructure-as-Code options.
