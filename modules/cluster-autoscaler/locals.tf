locals {
  name            = try(var.helm_config.name, "cluster-autoscaler")
  namespace       = try(var.helm_config.namespace, "kube-system")
  service_account = try(var.helm_config.service_account, "${local.name}-sa")
}
