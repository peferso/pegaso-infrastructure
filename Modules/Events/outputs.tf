output "ec2_manager_bus_arn" {
	value = aws_cloudwatch_event_bus.ec2_manager_msg_bus.arn
}
