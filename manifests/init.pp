# == Class: sc_mysecureshell
#
# Full description of class sc_mysecureshell here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { 'dummy':
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2016 Your name here, unless otherwise noted.
#
class sc_mysecureshell (

) {
  case $::operatingsystem {
    'Ubuntu': {
      case $::operatingsystemmajrelease {
        '14.04': {
          $source_dir = 'ubuntu_14.04'
        }
        '16.04': {
          $source_dir = 'ubuntu_16.04'
        }
        default: { fail('Operating System not supported.')}
      }
    }
    default: { fail('Operating System not supported.') }
  }

  # copy mysecure binaries
  file { '/usr/bin/mysecureshell':
    source => "puppet:///modules/$module_name/$source_dir/mysecureshell",
    mode => '4755',
  }

  file { '/usr/bin/sftp-admin':
    source => "puppet:///modules/$module_name/$source_dir/sftp-admin",
    mode => '700',
  }

  file { '/usr/bin/sftp-kill':
    source => "puppet:///modules/$module_name/$source_dir/sftp-kill",
    mode => '700',
  }

  file { '/usr/bin/sftp-state':
    source => "puppet:///modules/$module_name/$source_dir/sftp-state",
    mode => '700',
  }

  file { '/usr/bin/sftp-user':
    source => "puppet:///modules/$module_name/$source_dir/sftp-user",
    mode => '755',
  }

  file { '/usr/bin/sftp-verif':
    source => "puppet:///modules/$module_name/$source_dir/sftp-verif",
    mode => '755',
  }

  file { '/usr/bin/sftp-who':
    source => "puppet:///modules/$module_name/$source_dir/sftp-who",
    mode => '755',
  }


  file { '/etc/ssh/sftp.d':
    ensure => directory,
  }->

  file { '/etc/ssh/sftp.d/default.conf':
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template("${module_name}/default.conf.erb"),
  }->

  file { '/etc/ssh/sftp_config':
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    ensure  => 'present',
  }->
  file_line { 'includes':
    path    => '/etc/ssh/sftp_config',
    line    => 'Include /etc/sftp.d/default.conf	#include default params',
  }

  file_line { 'shell_entry':
    path    => '/etc/shells',
    line    => '/usr/bin/mysecureshell',
  }
}
