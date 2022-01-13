# ================================================================================ #
# SecurityGroups Module: input variables
# -------------------------------------------------------------------------------- #
# * Those with default values are not required to be given when calling the module 
#   in root folder.
# * But if given, these values will override default ones.
# -------------------------------------------------------------------------------- #
# vpcID (string)
# adminIP (string)
# ================================================================================ #

variable "vpcID" {
  type        = string
  description = "The ID of the VPC"
  default     = "vpc-0ff79b51c20ef8673"
}

variable "adminIP" {
  type        = string
  description = "IP address from which we connect to the EC2 instances using ssh"
  default     = "82.159.78.28/32"
}
