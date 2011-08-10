#This will install mysql
# TODO: make linux distro-independent (works only on Ubuntu/Debian now)
class mysql::install {
	package { [ "mysql-server", "mysql-client" ]:
	ensure => present,
	require => User["mysql"],
}

	user { "mysql":
		ensure => present,
		comment => "MySQL user",
		gid => "mysql",
		shell => "/bin/false",
		require => Group["mysql"],
}

	group { "mysql":
		ensure => present,
}
	service { "mysql":
		ensure => running,
		hasstatus => true,
		hasrestart => true,
		require => File ["/etc/mysql/my.cnf"]
}
	file { "/etc/mysql/my.cnf":
		ensure => present,
		source => "puppet:///modules/mysql/my.cnf",
		owner => "mysql",
		group => "mysql",
		require => Package ["mysql-server"]
}
}

