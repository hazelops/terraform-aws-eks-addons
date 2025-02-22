## Migration Guide: EKS Blueprints Addons to This Module

This document provides a step-by-step guide on migrating from the EKS Blueprints Addons module to this module.
Module follows a similar structure but includes fixes for known issues and supports a limited set of addons.

### List Of Supported Addons

 - Certificate Manager
 - External DNS
 - External Secrets
 - Datadog Operator
 - Ingress Nginx
 - Metrics Server
 - FluentBit
 - AWS Load Balancer

### 📌 1. Migration Considerations

Before migrating, consider the following:

✅ This module is designed to be backward-compatible with the Blueprints module.

⚡ It includes a restricted set of addons with minor improvements over the original module.

🔄 If the old module is already deployed, special steps are required to ensure a smooth transition.

### 🔄 2. Migration Scenarios

#### 🏗️ A. If the Old Module is Already Deployed

If we have an existing EKS cluster with the Blueprints module deployed:

##### 1️⃣ Backup Configuration

Export the existing Terraform state:

terraform state pull > eks-blueprints-backup.tfstate

Backup the terraform.tfvars or equivalent configuration file.

##### 2️⃣ Destroy the Old Module (Optional)

If a clean migration is preferred, destroy the old module before applying the new one:

```bash
terraform destroy -target=module.eks_blueprints_addons
```
This step is optional but recommended if we want to remove all traces of the old module.

##### 3️⃣ Replace Module References

Updatewe Terraform configuration to use this module:
```hcl
module "terraform_aws_eks_addons" {
source = "path/to/this/module"
cluster_name = var.cluster_name
addons = var.addons
}
```

Ensure that the addons variable only includes the supported addons from this module.

##### 4️⃣ Run Terraform Apply

```hcl
terraform init
terraform apply -auto-approve
```

This will deploy the supported addons using this module.

#### 🚀 B. Deploying from Scratch

If we want to deploy a new EKS cluster and want to use this module to deploy addons:

##### 1️⃣ Initialize Terraform

```hcl
terraform init
```

##### 2️⃣ Apply Configuration
```hcl
terraform apply -auto-approve
```

This will install the supported addons with the necessary fixes.
