locals {
  name      = try(var.helm_config.name, "ingress-nginx")
  namespace = try(var.helm_config.namespace, local.name)
}
