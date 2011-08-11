#!/bin/sh 
#This will restore MySql database
mysql_password=
app_mysql_dbname=$1
app_mysql_dump_location_for_dbrestore=$2
mysql --user=root --password=$mysql_password  $app_mysql_dbname < $app_mysql_dump_location_for_dbrestore
echo Result: $?

