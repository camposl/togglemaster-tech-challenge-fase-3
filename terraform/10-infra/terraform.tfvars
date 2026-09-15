project             = "togglemaster"
environment         = "prod"
owner               = "lucas-fase3"
aws_region          = "us-east-1"
use_academy_labrole = true
academy_role_name   = "LabRole"

vpc_cidr           = "10.0.0.0/16"
single_nat_gateway = true

cluster_version     = "1.35"
node_instance_types = ["t3.medium"]
node_min_size       = 2
node_desired_size   = 3
node_max_size       = 5
