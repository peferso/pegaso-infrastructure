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
$cat ~/.profile_PEGASO
# added manually for chromedriver

export PATH=$PATH:/home/pietari/chromedriver/chromedriver

# pegaso project environment variables
export hostIP=`hostname -I`
export URL='https://www.milanuncios.com/coches-de-segunda-mano/?demanda=n&orden=date&fromSearch='
export PEGASO_COLLT_DIR='<<local path to this repository>>'
export PEGASO_INFRA_DIR='<<local path to this repository>>'
export PEGASO_WEBST_DIR='<<local path to this repository>>'
export PEGASO_TRAIN_DIR='<<local path to this repository>>'
export CHROMEDRIVER_DIR=${HOME}'/chromedriver/chromedriver'
export SSH_KEYS_DIR=${HOME}'/ssh-keys'
export SSH_KEY_APPLCTN='key-pair-Linux-AMI-root.pem'
export SSH_KEY_DATABAS='key-pair-Linux-AMI-root.pem'
export DBHOST=13.38.46.143
export DBUSER='ec2-dbuser'
export DBPASS=
export RF_API_PORT=8081
export RF_API_ENDPOINT=${hostIP/ /}:$RF_API_PORT
export RF_JENKINS_PORT=8080

shopt -s expand_aliases

# pegaso project aliases
alias discover_instances=" aws ec2 --profile ec2Manager  describe-instances --query \"Reservations[].Instances[].{insId: InstanceId, pubIp: PublicIpAddress, insSt: State.Name, name: Tags[?Key == 'Name'].Value | [0]} | []\""

alias get_db_ip="discover_instances | grep -B2 \"dev-0-database_ec2\" | grep \"pubIp\" | sed 's/,//' | awk -F \": \" '{print \$2}' | sed 's/\"//g'"
alias get_ap_ip="discover_instances | grep -B2 \"dev-0-vanilla_ec2\" | grep \"pubIp\" | sed 's/,//' | awk -F \": \" '{print \$2}' | sed 's/\"//g'"

alias get_db_id="discover_instances | grep -B3 \"dev-0-database_ec2\" | grep \"insId\" | sed 's/,//' | awk -F \": \" '{print \$2}' | sed 's/\"//g'"
alias get_ap_id="discover_instances | grep -B3 \"dev-0-vanilla_ec2\" | grep \"insId\" | sed 's/,//' | awk -F \": \" '{print \$2}' | sed 's/\"//g'"

alias start_db="aws ec2 --profile ec2Manager  start-instances --instance-ids \`get_db_id\`"
alias stop_db="aws ec2 --profile ec2Manager  stop-instances --instance-ids \`get_db_id\`"

alias start_ap="aws ec2 --profile ec2Manager  start-instances --instance-ids \`get_ap_id\`"
alias stop_ap="aws ec2 --profile ec2Manager  stop-instances --instance-ids \`get_ap_id\`"

alias refresh_environment="source ~/.profile_PEGASO"
alias deploy_infrastructure="$PEGASO_INFRA_DIR/Utilities/bash-scripts/deploy-infrastructure.sh"
alias ssh_app="ssh -i ${SSH_KEYS_DIR}/${SSH_KEY_APPLCTN} -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no ec2-user@\`get_ap_ip\`"
alias ssh_database="ssh -i ${SSH_KEYS_DIR}/${SSH_KEY_APPLCTN} -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no ec2-user@\`get_db_ip\`"
alias launch_website="cd $PEGASO_WEBST_DIR ; source bin/activate ; cd src; python manage.py runserver; "
alias connect_to_database="mysql -u${DBUSER} -h\`get_db_ip\` -p$DBPASS"
alias run_database_procedure="mysql -N -B -u${DBUSER} -h\`get_db_ip\` -p$DBPASS"

echo -e "\nProfile loaded from $0 - `date +'%Y%m%d %H:%M:%S'`\n"

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
