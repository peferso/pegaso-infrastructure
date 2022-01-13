# ================================================================================ #
# SecurityGroups Module: output variables
# -------------------------------------------------------------------------------- #
# * This variables can be used in main.tf in root module or other modules.
# -------------------------------------------------------------------------------- #
# clientEC2SecGrID (string)
# serverEC2SecGrID (string)
# ================================================================================ #

output "clientEC2SecGrID" {
	description = "The security group ID of the client EC2 instance"
	value = aws_security_group.vanilla_ec2.id
}

output "serverEC2SecGrID" {
	description = "The security group ID of the server EC2 instance"
	value = aws_security_group.database_ec2.id
}
