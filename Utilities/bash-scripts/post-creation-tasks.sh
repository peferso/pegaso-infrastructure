#!/bin/bash

source ~/.profile

MAINDIR=$PEGASO_INFRA_DIR
PLAYBOOKSDIR=$MAINDIR/Utilities/ansible-playbooks
DBSETUP="db-server-setup.yml"
DBANSCONFIGFILE="db-server-setup.cfg"
CFGVAR="ANSIBLE_CONFIG"

create_environment_variable_ansiblecfg_dir() {
  MSSGENV="
  # ========================================================
  # + ... Using .cfg file:
  # > ${PLAYBOOKSDIR}/${1}
  # + ... Creating environment variable: ${CFGVAR}
  # ========================================================
  "
  echo "${MSSGENV}"
  export ${CFGVAR}=${PLAYBOOKSDIR}/${1}
}

delete_environment_variable_ansiblecfg_dir() {
  MSSGENV="
  # ========================================================
  # + ... deleting environment variable: ${CFGVAR}
  # ========================================================
  "
  echo "${MSSGENV}"
  unset ${CFGVAR} 
}

run_ansible_playbook() {
  MSSGPLBK="
  # ========================================================
  # + ... Running the playbook: 
  # > ${PLAYBOOKSDIR}/${1}
  # ========================================================
  "
  echo "${MSSGPLBK}"
  #ansible-playbook -vvv ${PLAYBOOKSDIR}/${1} --extra-vars "db_user=$DBUSER db_pass=$DBPASS mysqlrootpasswd=$DBPASS"
  ansible-playbook ${PLAYBOOKSDIR}/${1} --extra-vars "db_user=$DBUSER db_pass=$DBPASS mysqlrootpasswd=$DBPASS"
}

# Main

create_environment_variable_ansiblecfg_dir "${DBANSCONFIGFILE}"

run_ansible_playbook "${DBSETUP}"

delete_environment_variable_ansiblecfg_dir 
