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
  terraform apply
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

find_and_export_db_ip () { 
  cd ${MAINDIR} 
  outputList="$(terraform output)" 
  outputList=${outputList//' = '/'='} 
  outputList=$(echo "$outputList" | tr '\n' ' ') 
  outputList=${outputList//[' "']/} 
  outputList=(${outputList//']'/'] '}) 
  delimiter="=" 
  modNames=(); 
  insPubIP=(); 
  for element in "${outputList[@]}" 
  do 
    partLeftt=${element%%"${delimiter}"*} 
    partRight=${element#*"${delimiter}"} 
    partRight=$( echo  "${partRight//['\"\,\[\]']/}"  ) 
    if [[ ${partLeftt} == *"PublicIP"* ]] && [[ ${partLeftt} == *"${ec2_type}"* ]];  
    then 
      publicIP=${partRight} 
    fi 
  done 
  cd - > /dev/null  
  lineNumber=$(grep -n 'DBHOST' ~/.profile)
  lineNumber=$(echo ${lineNumber%%':'*})
  sed -i "${lineNumber}s+.*+DBHOST=${publicIP}+" ~/.profile
  source ~/.profile
} 

# Main

get_current_public_ip

updating_security_group_template_with_new_public_IP

invoke_terraform_init

invoke_terraform_apply

invoke_update_ansible_inventory

invoke_post_creation_tasks

find_and_export_db_ip


