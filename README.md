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
