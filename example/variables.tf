variable "env" {}
variable "aws_profile" {}
variable "aws_region" {}
variable "ssh_public_key" {}
variable "namespace" {}
variable "root_domain_name" {}
variable "ec2_key_pair_name" {}

locals {
  ec2_key_pair_name = "${var.env}-${var.namespace}"
}