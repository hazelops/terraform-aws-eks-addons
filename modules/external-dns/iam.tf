# IAM Policy

resource "aws_iam_policy" "external_dns" {
  description = "External DNS IAM policy."
  name        = "${var.addon_context.eks_cluster_id}-${local.name}-irsa"
  path        = var.addon_context.irsa_iam_role_path
  policy      = data.aws_iam_policy_document.external_dns_iam_policy_document.json
  tags        = var.addon_context.tags
}

data "aws_route53_zone" "selected" {
  name         = var.domain_name
  private_zone = var.private_zone
}
