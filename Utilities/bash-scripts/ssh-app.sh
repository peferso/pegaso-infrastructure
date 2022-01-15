#!/bin/bash

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

ec2_type='EC2Vanilla'

find_ip () {
  cd ${MAINDIR}
  outputList="$(terraform output)"
  outputList=${outputList//' = '/'='}
  outputList=$(echo "$outputList" | tr '\n' ' ')
  outputList=${outputList//' '/}
  outputList=${outputList//'"'/}
  outputList=(${outputList//']'/'] '})
  delimiter="="
  modNames=();
  insPubIP=();
  while IFS= read -r line
  do
    partLeftt=${line%%"${delimiter}"*}
    partLeftt=${partLeftt%"_"*}
    partRight=${line#*"${delimiter}"}
    partRight=$( echo  "${partRight//\"/}"  )
    modNames+=( ${partLeftt} );
    insPubIP+=( ${partRight} );
  done <<< "${outputList}"
  cd -
}

confirm $1

find_ip
