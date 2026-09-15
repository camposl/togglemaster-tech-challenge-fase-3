variable "project" {
  description = "Prefixo de nomenclatura de todos os recursos."
  type        = string
  default     = "togglemaster"
}

variable "environment" {
  description = "Ambiente logico (prod, hml, dev)."
  type        = string
  default     = "prod"
}

variable "owner" {
  description = "Identifica seus recursos numa conta compartilhada."
  type        = string
  default     = "lucas-fase3"
}

variable "aws_region" {
  description = "Regiao AWS. O AWS Academy Learner Lab libera apenas us-east-1 e us-west-2."
  type        = string
  default     = "us-east-1"
}

variable "use_academy_labrole" {
  description = <<-EOT
    true  = AWS Academy: nenhuma role/policy IAM e criada; EKS e node groups
            usam a LabRole existente, resolvida via data source.
    false = conta pessoal: as roles IAM sao criadas pelo Terraform.
  EOT
  type        = bool
  default     = true
}

variable "academy_role_name" {
  type    = string
  default = "LabRole"
}

variable "extra_tags" {
  type    = map(string)
  default = {}
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "single_nat_gateway" {
  type    = bool
  default = true
}

variable "cluster_version" {
  description = "1.35: STANDARD_SUPPORT ate 26/03/2027, uma minor atras da default (1.36)."
  type        = string
  default     = "1.35"
}

variable "node_instance_types" {
  type    = list(string)
  default = ["t3.medium"]
}

variable "node_min_size" {
  type    = number
  default = 2
}

variable "node_desired_size" {
  type    = number
  default = 3
}

variable "node_max_size" {
  type    = number
  default = 5
}
