# ================================================================================ #
#                       main.tf file of: SecurityGroups Module 
# This template creates the security groups of a database (server) EC2 and a 
# vanilla (client) EC2 instances, and adds rules to allow 
#  - ingress tcp (ssh) from specific ip to database and vanilla EC2
#  - ingress tcp (ssh) from database EC2 to vanilla EC2
#  - ingress tcp (ssh) from vanilla EC2 to database EC2
#  - ingress icmp-ipv4 from vanilla EC2 to database EC2 (to make "ping")
#  - ingress icmp-ipv4 from database EC2 to vanilla EC2 (to make "ping")
#  - ingress tcp 3306 (mySQL) from vanilla EC2 to database EC2
# -------------------------------------------------------------------------------- #
# SecurityGroups Module: input variables
# -------------------------------------------------------------------------------- #
# * Declared in <<variables.tf>> file in Module´s folder.
# -------------------------------------------------------------------------------- #
# Optional:
#   vpcID (string)
#   adminIP (string)
# ================================================================================ #
# SecurityGroups Module: output variables
# -------------------------------------------------------------------------------- #
# * Declared in <<outputs.tf>> file in Module´s folder.
# -------------------------------------------------------------------------------- #
# clientEC2SecGrID (string)
# serverEC2SecGrID (string)
# ================================================================================ #

resource "aws_security_group" "vanilla_ec2" {
	vpc_id = var.vpcID
	name = "vanilla-ec2-security-group"
  	description = "Allow inbound traffic for vanilla ec2 instance"
 
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_security_group" "database_ec2" {
	vpc_id = var.vpcID
	name = "database-ec2-security-group"
  	description = "Allow inbound traffic for database ec2 instance"
  
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

# rule to allow ssh from laptop to instances

resource "aws_security_group_rule" "ssh_from_laptop_to_vanilla_ec2" {
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  cidr_blocks = [var.adminIP]
  
  security_group_id = aws_security_group.vanilla_ec2.id
}

resource "aws_security_group_rule" "ssh_from_laptop_to_database_ec2" {
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  cidr_blocks = [var.adminIP]
  
  security_group_id = aws_security_group.database_ec2.id
}

resource "aws_security_group_rule" "ssh_from_orchestrator_network_to_database_ec2" {
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  cidr_blocks = ["10.10.1.0/24"]
  
  security_group_id = aws_security_group.database_ec2.id
}

resource "aws_security_group_rule" "ssh_from_orchestrator_network_to_vanilla_ec2" {
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  cidr_blocks = ["10.10.1.0/24"]

  security_group_id = aws_security_group.vanilla_ec2.id
}

# rule to allow ssh from instances to instances

resource "aws_security_group_rule" "ssh_from_database_to_vanilla_ec2" {
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  source_security_group_id = aws_security_group.database_ec2.id
  
  security_group_id = aws_security_group.vanilla_ec2.id
}

resource "aws_security_group_rule" "ssh_from_vanilla_to_database_ec2" {
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  source_security_group_id = aws_security_group.vanilla_ec2.id
  
  security_group_id = aws_security_group.database_ec2.id
}

# rule to allow icmp-ipv4 traffic from instances to instances

resource "aws_security_group_rule" "icmp_from_database_to_vanilla_ec2" {
  type = "ingress"
  from_port = -1
  to_port = -1
  protocol = "icmp"
  source_security_group_id = aws_security_group.database_ec2.id
  
  security_group_id = aws_security_group.vanilla_ec2.id
}

resource "aws_security_group_rule" "icmp_from_vanilla_to_database_ec2" {
  type = "ingress"
  from_port = -1
  to_port = -1
  protocol = "icmp"
  source_security_group_id = aws_security_group.vanilla_ec2.id
  
  security_group_id = aws_security_group.database_ec2.id
}

resource "aws_security_group_rule" "tcp_3306_from_vanilla_to_database_ec2" {
  type = "ingress"
  from_port = 3306
  to_port = 3306
  protocol = "tcp"
  source_security_group_id = aws_security_group.vanilla_ec2.id
  
  security_group_id = aws_security_group.database_ec2.id
}
