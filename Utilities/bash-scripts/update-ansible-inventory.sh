#!/bin/bash

MAINDIR="../.."
HOSTSFILE="/etc/ansible/hosts"
DTSTAMP=$( echo "$(date +'%Y%m%d-%H_%M_%S_%3N')" )
INITMSSG="
# ========================================================
# + Script: update-ansible-inventory.sh
# >
# > Bash script that retrieves the list of running EC2
# > instances and private ip's and consistently updates
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
  outputList="$(terraform output | grep -i publicIp)"
  delimiter="="
  modNames=();
  insPubIP=();
  while IFS= read -r line
  do
    partLeftt=${line%%"$delimiter"*}
    partLeftt=${partLeftt%"_"*}
    partRight=${line#*"$delimiter"}
    partRight=$( echo  "${partRight//\"/}"  )
    modNames+=( ${partLeftt} );
    insPubIP+=( ${partRight} );
  done <<< "${outputList}"
  cd -
}

add_each_instance_in_1_group() {
  echo "# Update of Ansible host files: ${DTSTAMP}"> ${HOSTSFILE}
  numIPs=$(echo "${#insPubIP[@]}")
  ii="0"
  for i in "${insPrvIP[@]}" 
  do
    echo ["${modNames[${ii}]}"] >> "${HOSTSFILE}"
    echo " "                    >> "${HOSTSFILE}"
    echo  "${insPubIP[${ii}]}"  >> "${HOSTSFILE}"
    echo " "                    >> "${HOSTSFILE}"
    ii=$((${ii}+1)) 
  done
}

confirm $1

find_ips

add_each_instance_in_1_group

