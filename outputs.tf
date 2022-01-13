# + Outputs from EC2Database Module
#   - insID (string)
#   - insPublicIP (string)
#   - insPrivateIP (string)
#   - insPublicDNS (string)
#   - insState (string)

output "EC2Database_insID" {
  description = "ID of the database EC2 instance"
  value       = module.EC2Database.insID
}
output "EC2Database_insPublicIP" {
  description = "Public IP of the database EC2 instance"
  value       = module.EC2Database.insPublicIP
}
output "EC2Database_insPrivateIP" {
  description = "Private IP of the database EC2 instance"
  value       = module.EC2Database.insPrivateIP
}
output "EC2Database_insPublicDNS" {
  description = "Public DNS of the database EC2 instance"
  value       = module.EC2Database.insPublicDNS
}
output "EC2Database_insState" {
  description = "State of the database EC2 instance"
  value       = module.EC2Database.insState
}

# + Outputs from EC2Vanilla Module
#   - insID (string)
#   - insPublicIP (string)
#   - insPrivateIP (string)
#   - insPublicDNS (string)
#   - insState (string)

output "EC2Vanilla_insID" {
  description = "ID of the client EC2 instance"
  value       = module.EC2Vanilla.insID
}
output "EC2Vanilla_insPublicIP" {
  description = "Public IP of the client EC2 instance"
  value       = module.EC2Vanilla.insPublicIP
}
output "EC2Vanilla_insPrivateIP" {
  description = "Private IP of the client EC2 instance"
  value       = module.EC2Vanilla.insPrivateIP
}
output "EC2Vanilla_insPublicDNS" {
  description = "Public DNS of the client EC2 instance"
  value       = module.EC2Vanilla.insPublicDNS
}
output "EC2Vanilla_insState" {
  description = "State of the client EC2 instance"
  value       = module.EC2Vanilla.insState
}
  
# + Outputs from SecurityGroups Module
#   - clientEC2SecGrID (string)
#   - serverEC2SecGrID (string)

