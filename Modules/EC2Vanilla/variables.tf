# ================================================================================ #
# EC2Vanilla Module: input variables
# -------------------------------------------------------------------------------- #
# * Those with default values are not required to be given when calling the module 
#   in root folder.
# * But if given, these values will override default ones.
# -------------------------------------------------------------------------------- #
# ec2SubNt (string)
# secGrpID (string)
# amiType (string)
# insType (string)
# pathToUD (string)
# publicIP (logical)
# keyName (string)
# ================================================================================ #

variable "ec2SubNt" {
  type        = string
  description = "The public subnet where the EC2 will be created in the VPC"
}

variable "secGrpID" {
  type        = string
  description = "The ID of the security group"
}

variable "amiType" {
  type        = string
  description = "The ID corresponding to the Amazon Machine Image type (default is Amazon Linux 2)"
  default     = "ami-0de12f76efe134f2f"
}

variable "insType" {
  type        = string
  description = "The type of hardware of the EC2 instance (default is t2.micro which is <<free>>)"
  default     = "t2.micro"
}

variable "pathToUD" {
  type        = string
  description = "The path to the folder where the user data script is. Default is relative to folder´s module"
  default     = "./Modules/EC2Vanilla/user-data-va-ec2.sh"
}

variable "publicIP" {
  description = "Whether the instance will have a public IP address automatically generated"
  default     = true
}

variable "keyName" {
  type        = string
  description = "The name of the key pair used to ssh access the EC2 instance"
  default     = "key-pair-Linux-AMI-root"
}

variable "environmentName" {
  type        = string
  description = "The environment of the instance"
  default     = "Standard"
}

variable "number_of_environments" {
  type        = number
  description = "The number of EC2 instances to be created"
  default     = 1
}
