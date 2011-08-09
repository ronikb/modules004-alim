# The following are the settinsg variables required for the operations. Assign appropriate values 
#-------------------------------------------------------------------------------------------------
#The Github URL from where the application files to be taken
$application_drupal_gitclone_application="https://github.com/alim-foundation/www.alim.org.git"

#The destination folder in the server to where the application fiels to be cloned
$application_drupal_gitclone_application_destination="/var/www/www.alim.org/"

#Clone URL from where the database and files fodler of drupal to be cloned
$application_drupal_gitclone_db="git@github.com:netspective/medigy-drupal-db.git"

#The destination of the database and files folder
$application_drupal_gitclone_db_destination="/medigy/medigy-drupal-db/"

#The location from where the mysqldump to be restored
$application_mysql_dump_location_for_dbrestore="/home/alim/blueserf_alim_20110807010001.sql"

#The database name
$application_mysql_dbname="alim"

#The memeory limit of the PHP
$application_php_memory_limit="384M"

#The my.cnf file editing
$app_mysql_max_allowed_packet="500M"

#the default document root of apache2
$application_apache_default_documentroot="/var/www"

#the proposed document root of the apache2 
$application_apache_current_documentroot="/var/www/www.alim.org/"

#files folder drupal to which the sym link to be created
$application_drupal_symlink_files_folder_source="/alim/www.alim.org/sites/default/files"

#the destination symlink folder
$application_drupal_symlink_files_folder_destination="/var/www/www.alim.org/sites/default/files"

#necessary defaults
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
