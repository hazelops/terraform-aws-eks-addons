# Network
module "vpc" {
  source  = "registry.terraform.io/terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = "${var.env}-vpc"
  cidr = "10.30.0.0/16"

  azs = [
    "us-east-1a",
    "us-east-1b",
    "us-east-1c"
  ]
  public_subnets = [
    "10.30.10.0/23",
    "10.30.12.0/23",
    "10.30.14.0/23"
  ]

  private_subnets = [
    "10.30.20.0/23",
    "10.30.22.0/23",
    "10.30.24.0/23"
  ]

  enable_nat_gateway = true
  single_nat_gateway = true
  enable_vpn_gateway = false

  enable_dns_hostnames       = true
  enable_dns_support         = true
  manage_default_network_acl = true
  default_network_acl_name   = "${var.env}-${var.namespace}"
}

resource "aws_route53_record" "env_ns_record" {
  zone_id = data.aws_route53_zone.root.id
  name    = "${var.env}.${var.root_domain_name}"
  type    = "NS"
  ttl     = "60"
  records = aws_route53_zone.env_domain.name_servers
}

resource "aws_route53_zone" "env_domain" {
  name = "${var.env}.${var.root_domain_name}"
}
