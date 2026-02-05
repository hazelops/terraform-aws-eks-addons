module "helm_addon" {
  source = "../helm-addon"

  # https://github.com/kubernetes-sigs/external-dns/tree/master/charts/external-dns
  helm_config = merge(
    {
      description = "ExternalDNS Helm Chart"
      name        = local.name
      chart       = local.name
      repository  = var.ext_dns_repo
      version     = "1.15.2"
      namespace   = local.name
      values = [
        <<-EOT
          provider:
            name: aws
          env:
            - name: AWS_DEFAULT_REGION
              value: ${var.addon_context.aws_region_name}
        EOT
      ]
    },
    var.helm_config
  )

  set_values = concat(
    [
      {
        name  = "serviceAccount.name"
        value = local.service_account
      },
      {
        name  = "serviceAccount.create"
        value = false
      }
    ],
    try(var.helm_config.set_values, [])
  )

  irsa_config = {
    create_kubernetes_namespace         = try(var.helm_config.create_namespace, true)
    kubernetes_namespace                = try(var.helm_config.namespace, local.name)
    create_kubernetes_service_account   = true
    create_service_account_secret_token = try(var.helm_config["create_service_account_secret_token"], false)
    kubernetes_service_account          = local.service_account
    irsa_iam_policies                   = concat([aws_iam_policy.external_dns.arn], var.irsa_policies)
  }

  addon_context     = var.addon_context
  manage_via_gitops = var.manage_via_gitops
}
