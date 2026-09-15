variable "cluster_name" {
  type = string
}

variable "cluster_version" {
  type = string
}

variable "node_role_arn" {
  description = "LabRole no Academy; role criada pelo Terraform em conta pessoal."
  type        = string
}

variable "cluster_role_arn" {
  type = string
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "public_subnet_ids" {
  type = list(string)
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

variable "endpoint_public_access_cidrs" {
  description = "Restrinja ao seu IP em producao. 0.0.0.0/0 aqui porque o IP do Academy muda a cada sessao."
  type        = list(string)
  default     = ["0.0.0.0/0"]
}
