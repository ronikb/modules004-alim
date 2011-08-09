# This is a core file of application module

# Explanation of the following classes
#----------------------------------
#application::config -> Gitclone for database repository
#application::gitcloneapp-> Gitclone for application repository
#application::dbcreate-> MySql database creation
#application::dbrestore-> MySql database restore
#application::phpmemory->Change default PHP memory limit
#application::symlink-> Create symlink for files folder
#application::editfor_cleanurl-> Settings for enabling .htaccess file
#application::editfor_documentroot-> Edit default DocumentRoot path

class application {
	include application::test, application::gitcloneapp, application::dbcreate, application::dbrestore, application::php_memory, application::symlink, application::editfor_cleanurl, application::editfor_documentroot
}
