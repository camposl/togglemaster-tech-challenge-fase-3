locals {
  name_prefix  = "${var.project}-${var.environment}"
  cluster_name = "${var.project}-${var.environment}-eks"

  # Em conta pessoal (use_academy_labrole = false) este e o ponto onde um
  # modulo de IAM seria plugado, sem tocar nos demais modulos.
  cluster_role_arn = var.use_academy_labrole ? data.aws_iam_role.academy[0].arn : null
  node_role_arn    = var.use_academy_labrole ? data.aws_iam_role.academy[0].arn : null

  azs = slice(data.aws_availability_zones.available.names, 0, 3)

  common_tags = merge(
    {
      Project     = var.project
      Environment = var.environment
      ManagedBy   = "terraform"
      Stack       = "10-infra"
      Owner       = var.owner
      Repository  = "togglemaster-tech-challenge-fase-3"
    },
    var.extra_tags,
  )
}
