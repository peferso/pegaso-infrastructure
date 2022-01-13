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
echo " ===   of the database ec2-instance   === "
echo "                                          "
echo " Current Date-time stamp (YYYYMMDD HH:MM:SS:mS)"
echo "$(date +'%Y%m%d %H:%M:%S:%3N')"
echo "                                          "
echo "                                          "
echo " ---------------------------------------- "
echo "                                          "
echo " Step 1: mySQL installation begins        "
echo "                                          "
#sudo yum update –y
# First, we need to add the MySQL Yum repository to our Amazon Linux 2 server’s repository list.
#sudo yum install -y https://dev.mysql.com/get/mysql80-community-release-el7-3.noarch.rpm
# Once the repository has been added we install MySQL 8.
#sudo yum install -y mysql-community-server
# Start the service
#sudo systemctl enable --now mysqld

# Commands to print useful info
PUBLIC_IP=$(curl -s ifconfig.co)
#TEMP_PASSWD_MYSQL_ROOT=$(sudo grep 'temporary password' /var/log/mysqld.log)
#MYSQLPASSWD=$(echo $TEMP_PASSWD_MYSQL_ROOT | awk '{print $NF}')
echo 'PUBLIC_IP='$PUBLIC_IP >> /etc/environment 
#echo 'MYSQLPASSWD='$MYSQLPASSWD >> /etc/environment
customfile=/etc/profile.d/custom.sh
sudo touch $customfile
sudo echo 'echo "   "' >> $customfile
sudo echo 'echo "   "' >> $customfile
sudo echo 'echo "   "' >> $customfile
sudo echo 'echo " @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ "' >> $customfile
sudo echo 'echo " ================================== "' >> $customfile
sudo echo 'echo " ################################## "' >> $customfile
sudo echo 'echo " ================================== "' >> $customfile
sudo echo 'echo " "" Welcome ${USER} to the mySQL-database instance"' >> $customfile
sudo echo 'echo "   "' >> $customfile
sudo echo 'echo "   "' >> $customfile
sudo echo 'echo " ""The instance public IP address is:"' >> $customfile
sudo echo 'echo "   "' >> $customfile
sudo echo 'echo "   "$PUBLIC_IP' >> $customfile
sudo echo 'echo "   "' >> $customfile
sudo echo 'echo "   "' >> $customfile
sudo echo 'echo " ""The temporary mySQL password for root@localhost is:"' >> $customfile
sudo echo 'echo "   "' >> $customfile
sudo echo 'echo "   "$MYSQLPASSWD' >> $customfile
sudo echo 'echo "   "' >> $customfile
sudo echo 'echo "   "' >> $customfile
sudo echo 'echo " ""Run the following command to configure the mySQL server:"' >> $customfile
sudo echo 'echo "   "' >> $customfile
sudo echo 'echo "   ""sudo mysql_secure_installation -p$MYSQLPASSWD"' >> $customfile
sudo echo 'echo "   "' >> $customfile
sudo echo 'echo "   "' >> $customfile
sudo echo 'echo " ""Login as root user to MySQL shell:"' >> $customfile
sudo echo 'echo "   "' >> $customfile
sudo echo 'echo "   ""mysql -uroot -p"' >> $customfile
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
