#!/bin/bash

MAINDIR=$PEGASO_INFRA_DIR


  echo -ne 'Finding '${ec2_type}' public IP... |#   | - Refreshing terraform state                       \r'; sleep 1

#find_and_export_db_ip () { 

  cd ${MAINDIR} 
  
  terraform refresh

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

      echo -ne 'Finding '${ec2_type}' public IP... |##  | - IP '${publicIP}' was found                        \r'; sleep 1

    fi 

  done 

  cd - > /dev/null  

  echo -ne 'Finding '${ec2_type}' public IP... |### | - Modifying profile file ...                         \r'; sleep 1

  sed -i "s+export DBHOST=.*+export DBHOST=${publicIP}+" ~/.profile_PEGASO

  echo -ne 'Finding '${ec2_type}' public IP... |####| - Finished.                                          \r'; sleep 1

#} 

