#!/bin/bash

shopt -s expand_aliases

source ~/.profile_PEGASO

MAINDIR=$PEGASO_INFRA_DIR
DTSTAMP=$( echo "$(date +'%Y%m%d-%H_%M_%S_%3N')" )
INITMSSG="
# ========================================================
# + Script: $0 
# >
# > Bash script that retrieves the public IP of the 
# > application EC2 instance and consistently builds
# > the ssh command using an ssh provided by environment
# > variables defined in ~/.profile
# >   $0 -a
# >   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# ========================================================
"

confirm() {
  if [ "$1" != "-a" ]
  then
    echo "${INITMSSG}"
    exit
  fi
}

ec2_type='EC2Database'

find_ip () {
  cd ${MAINDIR}
  echo -ne 'Accessing '${ec2_type}' through ssh... |####      | - Refreshing terraform state                        \r'; sleep 1
  terraform refresh > /dev/null
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
      echo -ne 'Accessing '${ec2_type}' through ssh... |######    | - IP '${publicIP}' was found                        \r'; sleep 1
    fi
  done
  cd - > /dev/null 
}

# echo -ne 'Accessing '${ec2_type}' through ssh... |          | - Starting...                                                  \r'; sleep 1

confirm $1

# echo -ne 'Accessing '${ec2_type}' through ssh... |##        | - Finding the public IP of the EC2 instance...                 \r'; sleep 1

# find_ip

publicIP=$(get_db_ip)

publicIP=${publicIP//\"/}

# echo -ne 'Accessing '${ec2_type}' through ssh... |######### | - Invoking ssh using key pair...                               \r\r'; sleep 1; clear

ssh -i ${SSH_KEYS_DIR}/${SSH_KEY_APPLCTN} -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no ec2-user@${publicIP}
