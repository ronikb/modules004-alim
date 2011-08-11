# This will do application specific settings

#class app::gitclone_db {        
#	exec { "gitclone-db":
#		command => "git clone $app_drupal_gitclone_db $app_drupal_gitclone_db_destination",
#		timeout => 3600, 
#       logoutput=> on_failure, 
#		before => Class ["app::dbcreate"]
#}
#}
class app::gitclone_app {
	exec { "gitclone-application":
		command => "git clone $app_drupal_gitclone_application $app_drupal_gitclone_application_destination",
#		require => Class ["app::gitclone_db"]
}
}
class app::mysql_restart {
	exec { "restart_mysql_service": 
         command  => "/etc/puppet/modules/app/scripts/mysql-service-restart.sh", 
         before => Class ["app::dbcreate"]
} 
}
class app::dbcreate {
	exec { "db-create":
		command =>"/etc/puppet/modules/app/scripts/mysql-db-create.sh $app_mysql_dbname",
		require => Service ["mysql"]
}
}
class app::dbrestore {
	exec { "db-restore":
		command =>"/etc/puppet/modules/app/scripts/mysql-db-restore.sh $app_mysql_dbname $app_mysql_dump_location_for_dbrestore",
		timeout => 3600,
		logoutput=> on_failure,
		require => Class ["app::dbcreate"]
}
}
class app::php_memory {
	 exec { "increase-php-memory-limit":
			command => "sed -i 's/memory_limit = .*/memory_limit = $app_php_memory_limit/' /etc/php5/apache2/php.ini",
       	require => Package["php5"]
}
}
class app::symlink{
	exec { "symlink-for-files-folder":
		command => "ln -s $app_drupal_symlink_files_folder_source $app_drupal_symlink_files_folder_destination",
		require => Class ["app::gitclone_app"]
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
       command => "/etc/puppet/modules/app/scripts/edit-documentRoot-folder-path.sh $app_apache_default_documentroot $app_apache_current_documentroot",
      require => Package["apache2"]
}
}
class app::drupal_settings_file {
	file { "/etc/app/settings.php":
		ensure => present,
		source => "puppet:///modules/app/settings.php",
		owner => "root",
		group => "root",
		require => Class ["app::gitclone_app"]
}
}
class app::write_permissions_to_files_folder {
	exec { "write-permissions-to-files-folder":
		command => "/etc/puppet/modules/app/scripts/drupal-files-folder-permission.sh",
}
}

class app {
	include app::gitclone_app, app::mysql_restart, app::dbcreate, app::dbrestore, app::php_memory, app::symlink, app::edit_for_cleanurl, app::edit_for_documentroot, app::drupal_settings_file, app::write_permissions_to_files_folder
}

