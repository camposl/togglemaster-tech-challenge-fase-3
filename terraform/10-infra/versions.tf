terraform {
  required_version = "~> 1.15.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.64"
    }
  }

  backend "s3" {
    key          = "10-infra/terraform.tfstate"
    encrypt      = true
    use_lockfile = true
  }
}
