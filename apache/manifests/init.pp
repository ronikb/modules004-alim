#This will install apache2 packages in Ubuntu/Debian systems
#TODO: make linux distro-independent (works only on Ubuntu/Debian now)

class apache::install {
	package { [ "apache2" ]:
	ensure => present,
}
	service { "apache2":
		ensure => running,
		hasstatus => true,
		hasrestart => true,
		enable => true,
		require => Package ["apache2"],
}
}
class apache::modules {
	exec { "mod-rewrite-on":
		command =>"a2enmod rewrite",
		require => Service ["apache2"]
}
}

class apache {
	include apache::install, apache::modules
}

