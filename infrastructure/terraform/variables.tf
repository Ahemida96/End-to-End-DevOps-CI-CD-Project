variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
}

variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "subnet_cidr_block" {
  description = "The CIDR block for the subnets"
  type        = string
}

variable "public_subnet_name" {
  description = "The public subnet name"
  type        = string
}

variable "availability_zone" {
  description = "The availability zone"
  type        = string
  default     = "us-east-1a"
}

variable "key_name" {
	type				= string
  default   	= "terraform"
}