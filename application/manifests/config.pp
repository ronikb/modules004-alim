# This will do application specific settings

#class application::test {        
#	exec { "gitclone-db":
#		command => "git clone $application_drupal_gitclone_db $application_drupal_gitclone_db_destination",
#		timeout => 3600, 
#       logoutput=> on_failure, 
#		before => Class ["application::dbcreate"]
#}
#}
class application::gitcloneapp {
	exec { "gitclone-application":
		command => "git clone $application_drupal_gitclone_application $application_drupal_gitclone_application_destination",
#		require => Class ["application::test"]
}
}
class application::dbcreate {
	exec { "db-create":
		command =>"/etc/puppet/modules/application/scripts/mysql-db-create.sh $application_mysql_dbname",
		require => Service["mysql"]
}
}
class application::dbrestore {
	exec { "db-restore":
		command =>"/etc/puppet/modules/application/scripts/mysql-db-restore.sh $application_mysql_dbname $application_mysql_dump_location_for_dbrestore",
		require => Class ["application::dbcreate"],
}
}
class application::php_memory {
	 exec { "increase-php-memory-limit":
			command => "sed -i 's/memory_limit = .*/memory_limit = $application_php_memory_limit/' /etc/php5/apache2/php.ini",
       	require => Package["php5"]
}
}
class application::symlink{
	exec { "symlink-for-files-folder":
		command => "ln -s $application_drupal_symlink_files_folder_source $application_drupal_symlink_files_folder_destination",
		require => Class ["application::gitcloneapp"],
}
}
class application::editfor_cleanurl{
	exec { "edit-apache2-conf-file":
		command => "sed -i 's/AllowOverride None/AllowOverride All/' /etc/apache2/sites-available/default",
       require => Package["apache2"]
}
}
class application::editfor_documentroot{
	exec { "edit-documentRoot-folder-path":
       command => "/etc/puppet/modules/application/scripts/edit-documentRoot-folder-path.sh $application_apache_default_documentroot $application_apache_current_documentroot",
      require => Package["apache2"]
}
}
