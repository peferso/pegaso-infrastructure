variable "my_region" {
  type        = string
  description = "The AWS region where resources will be created"
  default     = "no_region_found"
}

variable "my_subnet_1" {
  type        = string
  description = "The public subnet 1 in  my AWS VPC"
  default     = "no_subnet_value_found"
}

variable "security_group_SSH_laptop" {
  type        = string
  description = "The security group ID that allows ssh from my home's IP"
  default     = "no_securiy_group_found"
}

variable "my_secret_key" {
  type        = string
}

variable "my_public_key" {
  type        = string
}

variable "environmentName" {
  type        = string
  description = "The value of the tag <<Environment>> of EC2 instances"
  default     = "Standard"
}

variable "number_of_environments" {
  description = "Number of client-server pairs to be created"
  type        = number
  default     = 1
}
