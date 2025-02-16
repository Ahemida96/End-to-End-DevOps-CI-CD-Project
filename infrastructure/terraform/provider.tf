terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws",
      version = "~> 5.0"
    }
    ansible = {
      source = "ansible/ansible"
      # version = "1.2.0"
    }
  }
}
