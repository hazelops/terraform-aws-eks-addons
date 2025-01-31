variable "eks_cluster_id" {
  description = "EKS Cluster Id"
  type        = string
}

variable "eks_cluster_domain" {
  description = "The domain for the EKS cluster"
  type        = string
  default     = ""
}

variable "data_plane_wait_arn" {
  description = "Addon deployment will not proceed until this value is known. Set to node group/Fargate profile ARN to wait for data plane to be ready before provisioning addons"
  type        = string
  default     = ""
}

variable "tags" {
  description = "Additional tags (e.g. `map('BusinessUnit`,`XYZ`)"
  type        = map(string)
  default     = {}
}

variable "irsa_iam_role_path" {
  description = "IAM role path for IRSA roles"
  type        = string
  default     = "/"
}

variable "irsa_iam_permissions_boundary" {
  description = "IAM permissions boundary for IRSA roles"
  type        = string
  default     = ""
}

variable "eks_oidc_provider" {
  description = "The OpenID Connect identity provider (issuer URL without leading `https://`)"
  type        = string
  default     = null
}

variable "eks_cluster_endpoint" {
  description = "Endpoint for your Kubernetes API server"
  type        = string
  default     = null
}

variable "custom_image_registry_uri" {
  description = "Custom image registry URI map of `{region = dkr.endpoint }`"
  type        = map(string)
  default     = {}
}

# #-----------CLUSTER AUTOSCALER ADDON-------------
# variable "enable_cluster_autoscaler" {
#   description = "Enable Cluster autoscaler add-on"
#   type        = bool
#   default     = false
# }
#
# variable "cluster_autoscaler_helm_config" {
#   description = "Cluster Autoscaler Helm Chart config"
#   type        = any
#   default     = {}
# }

#-----------External DNS ADDON-------------
variable "enable_external_dns" {
  description = "External DNS add-on"
  type        = bool
  default     = false
}

variable "external_dns_helm_config" {
  description = "External DNS Helm Chart config"
  type        = any
  default     = {}
}

variable "external_dns_irsa_policies" {
  description = "Additional IAM policies for a IAM role for service accounts"
  type        = list(string)
  default     = []
}

variable "external_dns_private_zone" {
  type        = bool
  description = "Determines if referenced Route53 zone is private."
  default     = false
}

variable "external_dns_route53_zone_arns" {
  description = "List of Route53 zones ARNs which external-dns will have access to create/manage records"
  type        = list(string)
  default     = []
}

# #-----------METRIC SERVER ADDON-------------
# variable "enable_metrics_server" {
#   description = "Enable metrics server add-on"
#   type        = bool
#   default     = false
# }
#
# variable "metrics_server_helm_config" {
#   description = "Metrics Server Helm Chart config"
#   type        = any
#   default     = {}
# }

# #-----------AWS LB Ingress Controller ADDON-------------
# variable "enable_aws_load_balancer_controller" {
#   description = "Enable AWS Load Balancer Controller add-on"
#   type        = bool
#   default     = false
# }
#
# variable "aws_load_balancer_controller_helm_config" {
#   description = "AWS Load Balancer Controller Helm Chart config"
#   type        = any
#   default     = {}
# }
#
# #-----------NGINX ADDON-------------
# variable "enable_ingress_nginx" {
#   description = "Enable Ingress Nginx add-on"
#   type        = bool
#   default     = false
# }
#
# variable "ingress_nginx_helm_config" {
#   description = "Ingress Nginx Helm Chart config"
#   type        = any
#   default     = {}
# }

# #-----------AWS FOR FLUENT BIT ADDON-------------
# variable "enable_aws_for_fluentbit" {
#   description = "Enable AWS for FluentBit add-on"
#   type        = bool
#   default     = false
# }
#
# variable "aws_for_fluentbit_helm_config" {
#   description = "AWS for FluentBit Helm Chart config"
#   type        = any
#   default     = {}
# }
#
# variable "aws_for_fluentbit_irsa_policies" {
#   description = "Additional IAM policies for a IAM role for service accounts"
#   type        = list(string)
#   default     = []
# }
#
# variable "aws_for_fluentbit_create_cw_log_group" {
#   description = "Set to false to use existing CloudWatch log group supplied via the cw_log_group_name variable."
#   type        = bool
#   default     = true
# }
#
# variable "aws_for_fluentbit_cw_log_group_name" {
#   description = "FluentBit CloudWatch Log group name"
#   type        = string
#   default     = null
# }
#
# variable "aws_for_fluentbit_cw_log_group_retention" {
#   description = "FluentBit CloudWatch Log group retention period"
#   type        = number
#   default     = 90
# }
#
# variable "aws_for_fluentbit_cw_log_group_kms_key_arn" {
#   description = "FluentBit CloudWatch Log group KMS Key"
#   type        = string
#   default     = null
# }

#-----------CERT MANAGER ADDON-------------
variable "enable_cert_manager" {
  description = "Enable Cert Manager add-on"
  type        = bool
  default     = false
}

variable "cert_manager_helm_config" {
  description = "Cert Manager Helm Chart config"
  type        = any
  default     = {}
}

variable "cert_manager_irsa_policies" {
  description = "Additional IAM policies for a IAM role for service accounts"
  type        = list(string)
  default     = []
}

variable "cert_manager_domain_names" {
  description = "Domain names of the Route53 hosted zone to use with cert-manager"
  type        = list(string)
  default     = []
}

variable "cert_manager_install_letsencrypt_issuers" {
  description = "Install Let's Encrypt Cluster Issuers"
  type        = bool
  default     = true
}

variable "cert_manager_letsencrypt_email" {
  description = "Email address for expiration emails from Let's Encrypt"
  type        = string
  default     = ""
}

variable "cert_manager_kubernetes_svc_image_pull_secrets" {
  description = "list(string) of kubernetes imagePullSecrets"
  type        = list(string)
  default     = []
}

#-----------EXTERNAL SECRETS ADDON-----------
variable "enable_external_secrets" {
  type        = bool
  default     = false
  description = "Enable External Secrets operator add-on"
}

variable "external_secrets_helm_config" {
  type        = any
  default     = {}
  description = "External Secrets operator Helm Chart config"
}

variable "external_secrets_irsa_policies" {
  description = "Additional IAM policies for a IAM role for service accounts"
  type        = list(string)
  default     = []
}

variable "external_secrets_ssm_parameter_arns" {
  description = "List of Systems Manager Parameter ARNs that contain secrets to mount using External Secrets"
  type        = list(string)
  default     = ["arn:aws:ssm:*:*:parameter/*"]
}

variable "external_secrets_secrets_manager_arns" {
  description = "List of Secrets Manager ARNs that contain secrets to mount using External Secrets"
  type        = list(string)
  default     = ["arn:aws:secretsmanager:*:*:secret:*"]
}

# #-----------ARGOCD ADDON-------------
# variable "enable_argocd" {
#   description = "Enable Argo CD Kubernetes add-on"
#   type        = bool
#   default     = false
# }
#
# variable "argocd_helm_config" {
#   description = "Argo CD Kubernetes add-on config"
#   type        = any
#   default     = {}
# }
#
# variable "argocd_applications" {
#   description = "Argo CD Applications config to bootstrap the cluster"
#   type        = any
#   default     = {}
# }
#
variable "argocd_manage_add_ons" {
  description = "Enable managing add-on configuration via ArgoCD App of Apps"
  type        = bool
  default     = false
}
