#!/bin/bash
echo " @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ "
echo " @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ "
echo " @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ "
echo " @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ "
echo " @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ "
echo " @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ "
echo " ================================================================================ "
echo " ################################################################################ "
echo " ================================================================================ "
echo "                                                                                  "
echo "               |    |  ----   ---  ---     --     --   -----   --                 "
echo "               |    | |      |    |   |   |  \   /  \    |    /  \                "
echo "               |    |  ----  |--- |---    |   | |    |   |   |    |               "
echo "               |    |      | |    |  \    |  /  |----|   |   |----|               "
echo "                \__/   ----   --- |   \    --   |    |   |   |    |               "
echo "                                                                                  "
echo " ======================================== "
echo " === Here starts the user data script === "
echo "                                          "
echo " Current Date-time stamp (YYYYMMDD HH:MM:SS:mS)"
echo "$(date +'%Y%m%d %H:%M:%S:%3N')"
echo "                                          "
echo "                                          "
echo " ---------------------------------------- "
echo "                                          "
echo " Step 1:     "
echo "                                          "
sudo yum update –y
echo " ---------------------------------------- "
echo "                                          "
echo " Step 1:     "
echo "                                          "
sudo yum install -y mysql

# Commands to print useful info after bash login
PUBLIC_IP=$(curl -s ifconfig.co)
echo 'PUBLIC_IP='$PUBLIC_IP >> /etc/environment
customfile=/etc/profile.d/custom.sh
sudo touch $customfile
> $customfile
sudo echo 'echo "   "' >> $customfile
sudo echo 'echo "   "' >> $customfile
sudo echo 'echo "   "' >> $customfile
sudo echo 'echo " @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ "' >> $customfile
sudo echo 'echo " ================================== "' >> $customfile
sudo echo 'echo " ################################## "' >> $customfile
sudo echo 'echo " ================================== "' >> $customfile
sudo echo 'echo " "" Welcome ${USER} to the vanilla instance"' >> $customfile
sudo echo 'echo "   "' >> $customfile
sudo echo 'echo "   "' >> $customfile
sudo echo 'echo " ""The instance public IP address is:"' >> $customfile
sudo echo 'echo "   "' >> $customfile
sudo echo 'echo "   "`curl -s ifconfig.co`' >> $customfile
sudo echo 'echo "   "' >> $customfile
sudo echo 'echo " ""Connect to the remote database as follows:"' >> $customfile
sudo echo 'echo "   "' >> $customfile
sudo echo 'echo "   ""mysql -u ec2-dbuser -h private-DB-IP -p password "' >> $customfile
sudo echo 'echo "   "' >> $customfile
sudo echo 'echo " ""Login as jenkins user:"' >> $customfile
sudo echo 'echo "   "' >> $customfile
sudo echo 'echo "   ""sudo su -s /bin/bash jenkins"' >> $customfile
sudo echo 'echo "   "' >> $customfile
sudo echo "alias showJenkinsURL='dum=\$(curl -s ifconfig.co);echo -e http://\${dum}:8080;'" >> $customfile
sudo echo 'echo " ""Show Jenkins url with alias:"' >> $customfile
sudo echo 'echo "   "' >> $customfile
sudo echo 'echo "   ""showJenkinsURL"' >> $customfile
sudo echo 'echo "   "`showJenkinsURL`' >> $customfile
sudo echo 'echo "   "' >> $customfile
sudo echo 'echo " ""Manage Jenkins:"' >> $customfile
sudo echo 'echo "   "' >> $customfile
sudo echo 'echo "   ""sudo service jenkins restart"' >> $customfile
sudo echo 'echo "   ""sudo service jenkins stop"' >> $customfile
sudo echo 'echo "   ""sudo service jenkins status"' >> $customfile
sudo echo 'echo "   "' >> $customfile
sudo echo 'echo " ""Switch default python version:"' >> $customfile
sudo echo 'echo "   "' >> $customfile
sudo echo 'echo "   ""update-alternatives --config python"' >> $customfile
sudo echo 'echo "   "' >> $customfile
sudo echo 'echo " ================================== "' >> $customfile
sudo echo 'echo " ################################## "' >> $customfile
sudo echo 'echo " ================================== "' >> $customfile
sudo echo 'echo " @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ "' >> $customfile
sudo echo 'echo "   "' >> $customfile
sudo echo 'echo "   "' >> $customfile
sudo echo 'echo "   "' >> $customfile
echo "                                          "
echo " Current Date-time stamp (YYYYMMDD HH:MM:SS:mS)"
echo "$(date +'%Y%m%d %H:%M:%S:%3N')"
echo "                                          "
echo " ======================================== "
echo " ==== Here ends the user data script ==== "
echo " ---------------------------------------- "
echo " ================================================================================ "
echo " ################################################################################ "
echo " ================================================================================ "
echo " @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ "
echo " @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ "
echo " @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ "
echo " @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ "
echo " @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ "
echo " @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ "
