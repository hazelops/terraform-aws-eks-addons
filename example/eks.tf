module "eks_cluster" {
  source                         = "registry.terraform.io/terraform-aws-modules/eks/aws"
  version                        = "~> 20.0"
  cluster_name                   = "${var.env}-${var.namespace}"
  cluster_version                = "1.31"
  cluster_endpoint_public_access = true

  create_cloudwatch_log_group = true

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  enable_cluster_creator_admin_permissions = true
  authentication_mode                      = "API_AND_CONFIG_MAP"
  # https://github.com/terraform-aws-modules/terraform-aws-eks/blob/master/docs/UPGRADE-20.0.md#authentication_mode--api_and_config_map

  cluster_addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
    aws-ebs-csi-driver = {
      most_recent = true
    }
  }

  eks_managed_node_groups = {
    initial = {
      instance_types = ["t3.mini"]
      min_size       = 2
      max_size       = 2
      desired_size   = 2
    }
  }


  node_security_group_additional_rules = {
    cluster_to_node = {
      description                   = "Cluster to ingress-nginx webhook"
      protocol                      = "-1"
      from_port                     = 8443
      to_port                       = 8443
      type                          = "ingress"
      source_cluster_security_group = true
    }
    ingress_self_all = {
      description = "Node to node all ports/protocols"
      protocol    = "-1"
      from_port   = 0
      to_port     = 0
      type        = "ingress"
      self        = true
    }
    egress_all = {
      description = "Node all egress"
      protocol    = "-1"
      from_port   = 0
      to_port     = 0
      type        = "egress"
      cidr_blocks = ["0.0.0.0/0"]
      #      ipv6_cidr_blocks = ["::/0"]
    }
  }
}

#EKS Cluster Add-ons local
module "eks_addons" {
  depends_on         = [module.eks_cluster]
  source             = "./../terraform/terraform-aws-eks-addons"
  eks_cluster_id     = module.eks_cluster.cluster_name
  eks_cluster_domain = var.root_domain_name

  enable_ingress_nginx                = true
  enable_aws_load_balancer_controller = true
  enable_cluster_autoscaler           = true
  enable_external_secrets             = true

  enable_external_dns = true
  external_dns_route53_zone_arns = [
    data.aws_route53_zone.root.arn,
    aws_route53_zone.env_domain.arn
  ]

  enable_cert_manager = true
  cert_manager_domain_names = [
    var.root_domain_name,
    aws_route53_zone.env_domain.name,
  ]

  enable_metrics_server = true

  enable_datadog_operator = true
}
