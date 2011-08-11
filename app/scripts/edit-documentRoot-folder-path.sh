#!/bin/sh
#This script is used to edit default DocumentRoot path
#var1=/var/www
app_apache_default_documentroot=$1
app_apache_current_documentroot=$2
#var2=/var/www/html/edge.devl.medigy.com/medigy-drupal/public_site/
sed -i "s%${app_apache_default_documentroot}%${app_apache_current_documentroot}%" /etc/apache2/sites-available/default
echo Result: $?
