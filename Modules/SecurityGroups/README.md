[//]: # (paste the content of this file onto a markdown editor or interpreter such as https://dillinger.io/ )

# Module SecurityGroups: template to create the Security Groups used by the DDBB and client EC2 instances.


It consists of four files: 

| File                | Description                          |
| :---                | ---:                                 |
| main.tf             | declaration of the ressource created |
| variables.tf        | input variables and default values   |
| outputs.tf          | output variables                     |

Example of usage in your root module with default configuration:
```sh
module "SecurityGroups" {
  source = "./Modules/SecurityGroups"
}
```

## variables.tf

The following variables are optional. If given, new values will override default ones:
* vpcID -- The ID of the VPC in which these groups and the EC2 instances will be created
* adminIP -- IP address from which we connect to the EC2 instances using ssh


## outputs.tf

The following outputs can be used in root module:
* clientEC2SecGrID (string) -- The security group ID of the client EC2 instance
* serverEC2SecGrID (string) -- The security group ID of the server EC2 instance

Refer to them in your root module as follows
```sh
module.SecurityGroups.output_variable
```
