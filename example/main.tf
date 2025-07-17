resource "aws_key_pair" "root" {
  key_name   = local.ec2_key_pair_name
  public_key = var.ssh_public_key

  lifecycle {
    ignore_changes = [
      public_key
    ]
  }
}
