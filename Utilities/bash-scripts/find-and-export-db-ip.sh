#!/bin/bash

MAINDIR=$PEGASO_INFRA_DIR

#find_and_export_db_ip () { 
  cd ${MAINDIR} 
  outputList="$(terraform output)" 
  outputList=${outputList//' = '/'='} 
  outputList=$(echo "$outputList" | tr '\n' ' ') 
  outputList=${outputList//[' "']/} 
  outputList=(${outputList//']'/'] '}) 
  delimiter="=" 
  ec2_type="EC2Database"
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
  sed -i "s+export DBHOST=.*+export DBHOST=${publicIP}+" ~/.profile_PEGASO
#} 

