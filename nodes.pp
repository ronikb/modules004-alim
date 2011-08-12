# The following are the settinsg variables required for the operations. Assign appropriate values 
#-------------------------------------------------------------------------------------------------
#The Github URL from where the application files to be taken
$app_drupal_gitclone_application="https://github.com/alim-foundation/www.alim.org.git"

#The destination folder in the server to where the application fiels to be cloned
$app_drupal_gitclone_application_destination="/var/www/www.alim.org/"

#The location from where the mysqldump to be restored
$app_mysql_dump_location_for_dbrestore="/home/alim/blueserf_alim_20110807010001.sql"

#The database name
$app_mysql_dbname="alim"

#The database username
$app_mysql_user="alimuser"

#The database password
$app_mysql_password="alim#@!"

#The memeory limit of the PHP
$app_php_memory_limit="384M"

#The default document root of apache2
$app_apache_default_documentroot="/var/www"

#The proposed document root of the apache2 
$app_apache_current_documentroot="/var/www/www.alim.org/"

#Files folder drupal to which the sym link to be created
$app_drupal_symlink_files_folder_source="/alim/files"

#The destination symlink folder
$app_drupal_symlink_files_folder_destination="/var/www/www.alim.org/sites/default/files"

#Necessary defaults
Exec { 
    path => ["/bin", "/sbin", "/usr/bin", "/usr/sbin"], 
}

# If you want to run this manifest for a specified system, put the system name instead of default. Default means it will run all the systems.
# If you don't want to install any of this modules , Please do delete that line and execute this manifest.


node default {
	include mysql
	include apache
	include php
    include app
}
