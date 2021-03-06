# Class: common::incron
#
# This class manages /etc/incron.allow and /etc/incron.deny and the
# incrond service.
#
class common::incron {

  common::incron::add_user { 'root': }

  concat_build { 'incron':
    order            => ['*.user'],
    clean_whitespace => 'leading',
    target           => '/etc/incron.allow'
  }

  file { '/etc/incron.deny':
    ensure => 'absent'
  }

  package { 'incron':
    ensure => latest
  }

  service { 'incrond':
    ensure     => 'running',
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
    require    => Package['incron']
  }
}
