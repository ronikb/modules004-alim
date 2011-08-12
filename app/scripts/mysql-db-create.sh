#!/bin/sh
#This will create MySql database
dbuser=root
app_mysql_user=$1
app_mysql_password=$2
app_mysql_dbname=$3
#STEP 1 - CREATE DB
#check if db exists first
echo "Creating a database for $app_mysql_dbname"
DBS=`mysql -u$dbuser -p$mysql_password -Bse 'show databases'| egrep -v 'information_schema|mysql'`
for db in $DBS; do
if [ "$db" = "$app_mysql_dbname" ]
then
echo "This database already exists : exiting now"
    exit
  fi
done
mysqladmin -u$dbuser -p$mysql_password create $app_mysql_dbname;
echo "Database $mysql_dbname created"
mysql -u root -h localhost -Bse "GRANT ALL PRIVILEGES ON $app_mysql_dbname.* TO '$app_mysql_user'@'localhost' IDENTIFIED BY '$app_mysql_password'"
