# This will secure server

class secureserver::iptables {
	file { "/etc/sysconfig/iptables":
		ensure => present,
		source => "puppet:///modules/secureserver/iptables",
		owner => "root",
		group => "root"		
}
}
class secureserver::service_iptable_restart {
	exec { "restart_iptables_service": 
         command  => "/etc/puppet/modules/secureserver/scripts/iptables-service-restart.sh", 
         before => Class ["secureserver::iptables"]
} 
}


class secureserver {
	include secureserver::iptables, secureserver::service_iptable_restart
}

