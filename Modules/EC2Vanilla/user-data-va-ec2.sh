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
sudo echo 'echo "   "$PUBLIC_IP' >> $customfile
sudo echo 'echo "   "' >> $customfile
sudo echo 'echo " ""Connect to the remote database as follows:"' >> $customfile
sudo echo 'echo "   "' >> $customfile
sudo echo 'echo "   "mysql -u ec2-dbuser -h <<private-DB-IP>> -p<<password>>"' >> $customfile
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
