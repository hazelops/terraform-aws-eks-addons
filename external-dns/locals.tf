locals {
  name            = try(var.helm_config.name, "external-dns")
  service_account = try(var.helm_config.service_account, "${local.name}-sa")

  argocd_gitops_config = merge(
    {
      enable             = true
      serviceAccountName = local.service_account
    },
    var.helm_config
  )
}
