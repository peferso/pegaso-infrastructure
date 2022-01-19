#!/bin/bash

source /home/pietari/.profile_PEGASO

MAINDIR=$PEGASO_INFRA_DIR
HOSTSFILE="/etc/ansible/hosts"
DTSTAMP=$( echo "$(date +'%Y%m%d-%H_%M_%S_%3N')" )
INITMSSG="
# ========================================================
# + Script: update-ansible-inventory.sh
# >
# > Bash script that retrieves the list of running EC2
# > instances and public ip's and consistently updates
# > the list of Ansible managed hosts:
# >  /etc/ansible/hosts
# > Note that to modify this file, the script must be 
# > called using sudo privileges.
# + To run it just call:
# >   sudo ./update-ansible-inventory.sh -a
# >   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# ========================================================
"


confirm() {
  if [ "$1" != "-a" ]
  then
    echo "${INITMSSG}"
    exit
  fi
}

find_ips () {
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
    if [[ ${partLeftt} == *"PublicIP"* ]];
    then
      modNames+=( ${partLeftt%%_*} );
      insPubIP+=( ${partRight} )
      echo 'Updating contents of '$HOSTSFILE' file |####      | - IP '${partRight}' was found...                                 '; sleep 2
    fi
  done
  cd - > /dev/null 
}

add_each_instance_in_1_group() {
  echo "# Update of Ansible host files: ${DTSTAMP}"> ${HOSTSFILE}
  numIPs=$(echo "${#insPubIP[@]}")
  ii="0"
  for i in "${insPubIP[@]}" 
  do
    echo ["${modNames[${ii}]}"] | tee -a "${HOSTSFILE}"
    echo " "                    | tee -a "${HOSTSFILE}"
    echo  "${insPubIP[${ii}]}"  | tee -a "${HOSTSFILE}"
    echo " "                    | tee -a "${HOSTSFILE}"
    ii=$((${ii}+1)) 
  done
}

confirm $1

echo

echo -ne 'Updating contents of '$HOSTSFILE' file |          | - Starting...                                                  \r'; sleep 2

echo -ne 'Updating contents of '$HOSTSFILE' file |##        | - Finding public IPs of deployed EC2 instances...              \r'; sleep 2

find_ips

echo -ne 'Updating contents of '$HOSTSFILE' file |#######   | - Replacing contents of ansible hosts file with the following: \r'; sleep 2

echo

add_each_instance_in_1_group

echo 'Updating contents of '$HOSTSFILE' file |##########| - Execution finished.                                            '; sleep 2

echo
