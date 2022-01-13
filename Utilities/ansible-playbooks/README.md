[//]: # (paste the content of this file onto a markdown editor or interpreter such as https://dillinger.io/ )

# Ansible playbook to configure a mySQL server

This repository contains the folders and ```*.yml``` files that are necessary for the Ansible playbook that configures a mySQL server and creates a database and database user.

The contents of this repository should be cloned to a linux machine with Ansible already installed.

## Pre-requisites: include target host IP in Ansible inventory under group [db_server]

The target servers that will be configured running this playbook should be included in the Ansible inventory: 
should be added to the ```/etc/ansible/hosts``` file in the Ansible server under the group

```sh
[dbec2server]

10.10.3.4
```

TODO: add it dynamically when the EC2 is created with terraform.

## Pre-requisites: allow passwordless ssh connection from Ansible server to target host

The Ansible server public ssh key should be added to each target db_server.

This is done first creating the ssh key pair:
```sh
$ ssh-keygen -t rsa
``` 

Then, storing the created Ansible server public key into the target db_server:
```sh
$ ssh-copy-id root@destinationIPaddress
```

If this does not work, it should be done manually, or dynamically during the instance creation.

Checking Ansible connection to remote hosts:
```sh
$ ansible all -m ping
```

Check your inventory: 
```sh
$ ansible-inventory –-list -y
```

## Run the playbook

In the Ansible playbook folder, run:

```sh
$ ansible-playbook db-server-setup.yml
```
or
```sh
$ ansible-playbook /path/to/playbook.yml
```

# References

[Tutorial ansible playbook for configuring mySQL server 1] <https://www.digitalocean.com/community/tutorials/how-to-create-an-ansible-playbook-to-automate-drupal-installation-on-ubuntu-14-04>

