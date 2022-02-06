#!/bin/bash

MAINDIR=$PEGASO_INFRA_DIR
SG_FILE_VARS=$PEGASO_INFRA_DIR'/Modules/SecurityGroups/variables.tf'

get_current_public_ip() {
  MSSGENV="
  # ========================================================
  # + ... Getting current public IP of local host
  # ========================================================
  "
  echo [$(date -u)] 
  echo "${MSSGENV}" 
  echo 
  publicIP=$(curl ifconfig.me 2>/dev/null)
  echo [$(date -u)] "The public IP of the local host is: "${publicIP} 
  echo 
}

updating_security_group_template_with_new_public_IP() {
  MSSGENV="
  # ========================================================
  # + ... Updating terraform template to allow connections
  # +     from local host IP in Security Group
  # ========================================================
  "
  echo [$(date -u)] 
  echo "${MSSGENV}"
  lineNumber=$(grep -n 'variable "adminIP"' $SG_FILE_VARS)
  lineNumber=$(echo ${lineNumber%%':'*})
  lineNumber=$((lineNumber + 3))
  sed -i "${lineNumber}s+.*+  default     = \"${publicIP}/32\"+" $SG_FILE_VARS
  echo [$(date -u)] "Contents of $SG_FILE_VARS modified: "
  grep -A 4 'variable "adminIP"' $SG_FILE_VARS
  echo
}

invoke_terraform_init() {
  MSSGENV="
  # ========================================================
  # + ... Invoking terraform init
  # ========================================================
  "
  echo [$(date -u)] 
  echo "${MSSGENV}"
  cd $MAINDIR
  terraform init
  cd - > /dev/null
  echo
}

invoke_terraform_apply() {
  MSSGENV="
  # ========================================================
  # + ... Invoking terraform apply
  # ========================================================
  "
  echo [$(date -u)] 
  echo "${MSSGENV}"
  cd $MAINDIR
  terraform apply -auto-approve
  cd - > /dev/null
  echo
}

invoke_update_ansible_inventory() {
  MSSGENV="
  # ========================================================
  # + ... Invoking bash Utilities: update_ansible_inventory
  # ========================================================
  "
  echo [$(date -u)] 
  echo "${MSSGENV}"
  cd $MAINDIR
  sudo Utilities/bash-scripts/update-ansible-inventory.sh -a
  cd - > /dev/null
  echo
}

invoke_post_creation_tasks() {
  MSSGENV="
  # ========================================================
  # + ... Invoking bash Utilities: post_creation_tasks 
  # ========================================================
  "
  echo [$(date -u)] 
  echo "${MSSGENV}"
  cd $MAINDIR
  sudo Utilities/bash-scripts/post-creation-tasks.sh
  cd - > /dev/null
  echo
}

# Main

get_current_public_ip

updating_security_group_template_with_new_public_IP

invoke_terraform_init

invoke_terraform_apply

invoke_update_ansible_inventory

start_time="$(date -u +%s)"
waittime=120
while true
do
  end_time="$(date -u +%s)"
  elapsed="$(($end_time-$start_time))"
  echo -ne 'Waiting '$waittime' seconds for instances to deploy: '$elapsed' seconds elapsed                         \r'
  if [ $elapsed -ge $waittime ];
  then
    break 
    echo
  fi
done

invoke_post_creation_tasks

$MAINDIR/Utilities/bash-scripts/find-and-export-db-ip.sh

shopt -s expand_aliases

source ~/.profile_PEGASO

connect_to_database < $MAINDIR/Utilities/sql/create_data_model.sql

connect_to_database < $MAINDIR/Utilities/sql/create_procedure_remove_rptd_itms.sql

