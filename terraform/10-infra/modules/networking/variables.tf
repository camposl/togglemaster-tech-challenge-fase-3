variable "name_prefix" {
  type = string
}

variable "cluster_name" {
  description = "Necessario para as tags de discovery que o EKS usa ao provisionar load balancers."
  type        = string
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "availability_zones" {
  type = list(string)
}

variable "single_nat_gateway" {
  description = "true = 1 NAT compartilhado (barato, SPOF). false = 1 por AZ (HA, ~3x o custo)."
  type        = bool
  default     = true
}
