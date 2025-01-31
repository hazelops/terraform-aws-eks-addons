#-----------------Kubernetes Add-ons----------------------

# module "aws_for_fluent_bit" {
#   count                    = var.enable_aws_for_fluentbit ? 1 : 0
#   source                   = "./aws-for-fluentbit"
#   helm_config              = var.aws_for_fluentbit_helm_config
#   irsa_policies            = var.aws_for_fluentbit_irsa_policies
#   create_cw_log_group      = var.aws_for_fluentbit_create_cw_log_group
#   cw_log_group_name        = var.aws_for_fluentbit_cw_log_group_name
#   cw_log_group_retention   = var.aws_for_fluentbit_cw_log_group_retention
#   cw_log_group_kms_key_arn = var.aws_for_fluentbit_cw_log_group_kms_key_arn
#   manage_via_gitops        = var.argocd_manage_add_ons
#   addon_context            = local.addon_context
# }

# module "aws_load_balancer_controller" {
#   count             = var.enable_aws_load_balancer_controller ? 1 : 0
#   source            = "./aws-load-balancer-controller"
#   helm_config       = var.aws_load_balancer_controller_helm_config
#   manage_via_gitops = var.argocd_manage_add_ons
#   addon_context     = merge(local.addon_context, { default_repository = local.amazon_container_image_registry_uris[data.aws_region.current.name] })
# }

module "cert_manager" {
  count                             = var.enable_cert_manager ? 1 : 0
  source                            = "./cert-manager"
  helm_config                       = var.cert_manager_helm_config
  manage_via_gitops                 = var.argocd_manage_add_ons
  irsa_policies                     = var.cert_manager_irsa_policies
  addon_context                     = local.addon_context
  domain_names                      = var.cert_manager_domain_names
  install_letsencrypt_issuers       = var.cert_manager_install_letsencrypt_issuers
  letsencrypt_email                 = var.cert_manager_letsencrypt_email
  kubernetes_svc_image_pull_secrets = var.cert_manager_kubernetes_svc_image_pull_secrets
}

module "external_dns" {
  source = "./external-dns"

  count = var.enable_external_dns ? 1 : 0

  helm_config       = var.external_dns_helm_config
  manage_via_gitops = var.argocd_manage_add_ons
  irsa_policies     = var.external_dns_irsa_policies
  addon_context     = local.addon_context

  domain_name       = var.eks_cluster_domain
  private_zone      = var.external_dns_private_zone
  route53_zone_arns = var.external_dns_route53_zone_arns
}

module "external_secrets" {
  source = "./external-secrets"

  count = var.enable_external_secrets ? 1 : 0

  helm_config                           = var.external_secrets_helm_config
  manage_via_gitops                     = var.argocd_manage_add_ons
  addon_context                         = local.addon_context
  irsa_policies                         = var.external_secrets_irsa_policies
  external_secrets_ssm_parameter_arns   = var.external_secrets_ssm_parameter_arns
  external_secrets_secrets_manager_arns = var.external_secrets_secrets_manager_arns
}

# module "cluster_autoscaler" {
#   source = "./cluster-autoscaler"
#
#   count = var.enable_cluster_autoscaler ? 1 : 0
#
#   eks_cluster_version = local.eks_cluster_version
#   helm_config         = var.cluster_autoscaler_helm_config
#   manage_via_gitops   = var.argocd_manage_add_ons
#   addon_context       = local.addon_context
# }

# module "ingress_nginx" {
#   count             = var.enable_ingress_nginx ? 1 : 0
#   source            = "./ingress-nginx"
#   helm_config       = var.ingress_nginx_helm_config
#   manage_via_gitops = var.argocd_manage_add_ons
#   addon_context     = local.addon_context
# }

# module "metrics_server" {
#   count             = var.enable_metrics_server ? 1 : 0
#   source            = "./metrics-server"
#   helm_config       = var.metrics_server_helm_config
#   manage_via_gitops = var.argocd_manage_add_ons
#   addon_context     = local.addon_context
# }
