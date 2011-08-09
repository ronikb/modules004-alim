# This will do application specific settings

#class app::gitclone_db {        
#	exec { "gitclone-db":
#		command => "git clone $application_drupal_gitclone_db $application_drupal_gitclone_db_destination",
#		timeout => 3600, 
#       logoutput=> on_failure, 
#		before => Class ["app::dbcreate"]
#}
#}
class app::gitclone_app {
	exec { "gitclone-application":
		command => "git clone $application_drupal_gitclone_application $application_drupal_gitclone_application_destination",
#		require => Class ["app::gitclone_db"]
}
}
class app::mysql_config {
	exec { "edit_max_allowed_packet":
		command => "sed -i 's/max_allowed_packet = .*/max_allowed_packet = $app_mysql_max_allowed_packet/' /etc/mysql/my.cnf",
		require => Service["mysql"]
}
}
class app::mysql_restart {
	exec { "mysql_service_restart":
		command => "service mysql restart"
		require => Class ["app::mysql_config"]
}
}
class app::dbcreate {
	exec { "db-create":
		command =>"/etc/puppet/modules/application/scripts/mysql-db-create.sh $application_mysql_dbname",
		require => Class ["app::mysql_restart"]
}
}
class app::dbrestore {
	exec { "db-restore":
		command =>"/etc/puppet/modules/application/scripts/mysql-db-restore.sh $application_mysql_dbname $application_mysql_dump_location_for_dbrestore",
		timeout => 3600
		require => Class ["app::dbcreate"],
}
}
class app::php_memory {
	 exec { "increase-php-memory-limit":
			command => "sed -i 's/memory_limit = .*/memory_limit = $application_php_memory_limit/' /etc/php5/apache2/php.ini",
       	require => Package["php5"]
}
}
class app::symlink{
	exec { "symlink-for-files-folder":
		command => "ln -s $application_drupal_symlink_files_folder_source $application_drupal_symlink_files_folder_destination",
		require => Class ["app::gitclone_app"],
}
}
class app::edit_for_cleanurl{
	exec { "edit-apache2-conf-file":
		command => "sed -i 's/AllowOverride None/AllowOverride All/' /etc/apache2/sites-available/default",
       require => Package["apache2"]
}
}
class app::edit_for_documentroot{
	exec { "edit-documentRoot-folder-path":
       command => "/etc/puppet/modules/application/scripts/edit-documentRoot-folder-path.sh $application_apache_default_documentroot $application_apache_current_documentroot",
      require => Package["apache2"]
}
}

class app {
	include app::gitclone_app, app::mysql_config, app::mysql_restart, app::dbcreate, app::dbrestore, app::php_memory, app::symlink, app::edit_for_cleanurl, app::edit_for_documentroot
}

