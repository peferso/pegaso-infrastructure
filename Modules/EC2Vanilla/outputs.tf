# ================================================================================ #
# EC2Vanilla Module: output variables
# -------------------------------------------------------------------------------- #
# * This variables can be used in main.tf in root module or other modules.
# -------------------------------------------------------------------------------- #
# insID (string)
# insPublicIP (string)
# insPublicDNS (string)
# insState (string)
# ================================================================================ #

output "insID" {
	description = "The instance ID"
	value = aws_instance.vanilla_ec2.*.id
}

output "insPublicIP" {
	description = "The instance public IP address"
	value = aws_instance.vanilla_ec2.*.public_ip
}

output "insPrivateIP" {
	description = "The instance public IP address"
	value = aws_instance.vanilla_ec2.*.private_ip
}

output "insPublicDNS" {
	description = "The instance public DNS address"
	value = aws_instance.vanilla_ec2.*.public_dns
}

output "insState" {
	description = "The instance state (pending, running, shutting-down, terminated, stopping, stopped)"
	value = aws_instance.vanilla_ec2.*.instance_state
}
