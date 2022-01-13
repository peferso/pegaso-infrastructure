[//]: # (paste the content of this file onto a markdown editor or interpreter such as https://dillinger.io/ )

# Module EC2Vanilla: template to create an EC2 database client instance.


It consists of four files: 

| File                | Description                          |
| :---                | ---:                                 |
| main.tf             | declaration of the ressource created |
| variables.tf        | input variables and default values   |
| outputs.tf          | output variables                     |
| user-data-va-ec2.sh | user data script with bash instructions to be executed when EC2 instance is created |

Example of usage in your root module with default configuration:
```sh
module "EC2Vanilla" {
  source = "./Modules/EC2Vanilla"
  ec2SubNt = # provide here subnet id
  secGrpID = # provide here the security group id
}
```
## variables.tf

The following variables are mandatory:
* ec2SubNt (string) -- The id of the subnet inside the VPC where the instance is created (must exist).
* secGrpID (string) -- The id of the security group of the EC2 instance created (must exist).

The following variables are optional. If given, new values will override default ones:
*   amiType (string) -- The ID corresponding to the Amazon Machine Image type (default is Amazon Linux 2).
*   insType (string) -- The type of hardware of the EC2 instance (default is t2.micro which is <<free>>).
*   pathToUD (string) -- The path to the folder where the user data script is. Default is relative to folder´s module.
*   publicIP (logical) -- Whether the instance will have a public IP address automatically generated. Default: ```true ```.
*   keyName (string) -- The name of the key pair used to ssh access the EC2 instance. Default is my personal key.


## outputs.tf

The following outputs can be used in root module:
* insID (string) -- The instance ID
* insPublicIP (string) -- The instance public IP address
* insPublicDNS (string) -- The instance public DNS address
* insState (string) -- The instance state (```pending, running, shutting-down, terminated, stopping, stopped```)

Refer to them in your root module as follows
```sh
module.EC2Vanilla.output_variable
```
## user-data-va-ec2.sh

This is a bash shell script that updates the Amazon Linux OS and performs the following actions:
* Installation of mySQL client 8
* Configures the environment to print out useful information after bash login

## Post creation steps:
No steps required.
