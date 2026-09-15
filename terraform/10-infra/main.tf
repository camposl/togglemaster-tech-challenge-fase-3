data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

data "aws_availability_zones" "available" {
  state = "available"

  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}

data "aws_iam_role" "academy" {
  count = var.use_academy_labrole ? 1 : 0
  name  = var.academy_role_name
}

module "networking" {
  source = "./modules/networking"

  name_prefix        = local.name_prefix
  cluster_name       = local.cluster_name
  vpc_cidr           = var.vpc_cidr
  availability_zones = local.azs
  single_nat_gateway = var.single_nat_gateway
}

module "eks" {
  source = "./modules/eks"

  cluster_name     = local.cluster_name
  cluster_version  = var.cluster_version
  cluster_role_arn = local.cluster_role_arn
  node_role_arn    = local.node_role_arn

  private_subnet_ids = module.networking.private_subnet_ids
  public_subnet_ids  = module.networking.public_subnet_ids

  node_instance_types = var.node_instance_types
  node_min_size       = var.node_min_size
  node_desired_size   = var.node_desired_size
  node_max_size       = var.node_max_size
}
