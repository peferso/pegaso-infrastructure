TODO:
- Retrieve DBUSER and DBPASS from env. vars
- Export DBHOST as env. var in ```deploy-infrastructure.sh```
- Build unix alias for DB connection in ```deploy-infrastructure.sh```

# pegaso-infrastructure
Terraform templates for database and app hosts

# Pre-requisites

Terraform installation on Ubuntu:

```bash
sudo apt-get update

sudo apt-get install -y gnupg software-properties-common curl

curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -

sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"

sudo apt-get update

sudo apt-get install terraform
```

Checking the installation 

```bash
terraform -help
```

IDE for Terraform on Ubuntu (optional).

Installing Visual Studio Code:

```bash
sudo apt install apt-transport-https

sudo apt update

sudo apt install code 
```

Open it with the command:

```bash
code
```

Ansible installation on Ubuntu:

```bash
sudo apt-get install ansible
```

# Environment requirements

The Terraform templates use environment variables to retrieve provider keys. They can be defined as follows if root ```sudo su root``` (example):

```bash
echo 'TF_VAR_my_secret_key="e11414AIb12mvVDasdf5adsW27pasdfPYoasI0dPFgOdFGa2JCJ7"' >> /etc/environment
echo 'TF_VAR_my_public_key="AKNOFASD37RASD43L4N"' >> /etc/environment
```

It also uses the following UNIX environment variables that should be defined in the ```.profile``` of the user deploying the infrastructure:

```bash
$cat ~/.profile
...
export PEGASO_INFRA_DIR='<<local path to this repository>>'
export SSH_KEYS_DIR='<<path to local folder including ssh key pairs used by EC2 instances>>'
export SSH_KEY_APPLCTN='<<the name of the key pair used by the app EC2 instance>>'
export SSH_KEY_DATABAS='<<the name of the key pair used by the app EC2 instance>>'
 
alias deploy_infrastructure="$PEGASO_INFRA_DIR/Utilities/bash-scripts/deploy-infrastructure.sh"
alias ssh_app="$PEGASO_INFRA_DIR/Utilities/bash-scripts/ssh-app.sh"
alias ssh_database="$PEGASO_INFRA_DIR/Utilities/bash-scripts/ssh-database.sh"
...
```

# Deployment

Infrastructure deployment can be achieved with:
```sh
$ deploy_infrastructure
```

Once in the repository folder, Terraform is started with:

```sh
terraform init
```

The configuration can be checked for code consistency:

```sh
terraform validate
```

The set of ressources to be deployed can be checked with:

```sh
terraform plan
```

Deployment with terraform is performed as follows:

```sh
terraform apply -auto-approve
```

The outputs can be retrieved after deployment also with:

```sh
terraform refresh
```

Destruction:

```sh
terraform destroy -auto-approve
```


## Utilities

There are bash utilities to 

### Connect to EC2 instances through ssh

The following scripts retrieve the public IPs from Terraform outputs and build the ssh call to access the EC2 instances

/Utilities/bash-scripts/ssh-app.sh
/Utilities/bash-scripts/ssh-database.sh

> Note that the instances are deployed using ssh key pairs. These keys are passed to the scripts as environment variables.

Define these variables in the .profile as follows

```bash
...
export SSH_KEYS_DIR='<<path to ssh keys folder>>'
export SSH_KEY_APPLCTN='key-pair-Linux-AMI-root'
export SSH_KEY_DATABAS='key-pair-Linux-AMI-root'
...
```

> Note that in order to ssh access to the EC2 instances you need to allow your public IP in ```Modules/SecurityGroups/variables.tf``` by setting the default value of ```adminIP``` variable.

### Update Ansible inventory with App and database hosts IPs

TODO doc
