
# output "aws_for_fluent_bit" {
#   description = "Map of attributes of the Helm release and IRSA created"
#   value       = try(module.aws_for_fluent_bit[0], null)
# }
#
# output "aws_load_balancer_controller" {
#   description = "Map of attributes of the Helm release and IRSA created"
#   value       = try(module.aws_load_balancer_controller[0], null)
# }

output "cert_manager" {
  description = "Map of attributes of the Helm release and IRSA created"
  value       = try(module.cert_manager[0], null)
}

# output "cluster_autoscaler" {
#   description = "Map of attributes of the Helm release and IRSA created"
#   value       = try(module.cluster_autoscaler[0], null)
# }

output "external_dns" {
  description = "Map of attributes of the Helm release and IRSA created"
  value       = try(module.external_dns[0], null)
}

output "external_secrets" {
  description = "Map of attributes of the Helm release and IRSA created"
  value       = try(module.external_secrets[0], null)
}

# output "ingress_nginx" {
#   description = "Map of attributes of the Helm release and IRSA created"
#   value       = try(module.ingress_nginx[0], null)
# }
#
#
# output "metrics_server" {
#   description = "Map of attributes of the Helm release and IRSA created"
#   value       = try(module.metrics_server[0], null)
# }
