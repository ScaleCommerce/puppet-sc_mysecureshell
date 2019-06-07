# == Class: sc_mysecureshell
#
# Installation and configuration of mysecureshell
# Original config file /etc/ssh/sftp_config will contain only includes which are
# taken from /etc/ssh/sftp.d. Main config can be found in /etc/ssh/sfpt.d/default.conf.
# More config include files can be generated by sc_mysecureshell::config_tag
#
# === Examples
#
#  class { 'sc_mysecureshell':
#
#  }
#
# --- hiera example
#
# classes:
#   - sc_mysecureshell
#
# === Authors
#
# Author Name <az@scale.sc>
#
# === Copyright
#
# Copyright ScaleCommerce GmbH 2016
#
# === Parameters
#
# [*global_download*]
#   total speed download for all clients
#
# [*global_upload*]
#   total speed download for all clients (0 for unlimited)
#
# [*download*]
#   limit speed download for each connection
#
# [*upload*]
#   unlimit speed upload for each connection
#
# [*stay_at_home*]
#   limit client to his home
#
# [*virtual_chroot*]
#   fake a chroot to the home account
#
# [*limit_connection*]
#   max connection for the server sftp
#
# [*limit_connection_by_user*]
#   max connection for the account
#
# [*limit_connection_by_ip*]
#   max connection by ip for the account
#
# [*home*]
#   overrite home of the user but if you want you can use
#
# [*idle_time_out*]
#   (in second) deconnect client is idle too long time
#
# [*resolve_ip*]
#   resolve ip to dns
#
# [*ignore_hidden*]
#   treat all hidden files as if they don't exist
#
# [*hide_no_access*]
#   Hide file/directory which user has no access
#
# [*default_rights*]
#   Set default rights for new file and new directory
#
# [*show_links_as_links*]
#   show links as their destinations
#

class sc_mysecureshell (
  $global_download          = 0,	            #total speed download for all clients
  $global_upload            = 0,	            #total speed download for all clients (0 for unlimited)
  $download                 = 0,	            #limit speed download for each connection
  $upload                   = 0,	            #unlimit speed upload for each connection
  $stay_at_home             = true,	          #limit client to his home
  $virtual_chroot           = true,	          #fake a chroot to the home account
  $limit_connection         = 10,	            #max connection for the server sftp
  $limit_connection_by_user =	10,	            #max connection for the account
  $limit_connection_by_ip   = 10,	            #max connection by ip for the account
  $home                     = '/home/$USER',	#overrite home of the user but if you want you can use
  $idle_time_out            = '5m',	          #(in second) deconnect client is idle too long time
  $resolve_ip               = false,	        #resolve ip to dns
  $ignore_hidden            = false,	          #treat all hidden files as if they don't exist
  $hide_no_access           = true,	          #Hide file/directory which user has no access
  $default_rights           = '0640 0750',	  #Set default rights for new file and new directory
  $show_links_as_links      = false,	        #show links as their destinations
) {
  case $::operatingsystem {
    'Ubuntu': {
      case $::operatingsystemrelease {
        '14.04': {
          $source_dir = 'ubuntu_14.04'
        }
        '16.04': {
          $source_dir = 'ubuntu_16.04'
        }
        '18.04': {
          $source_dir = 'apt'
        }
        default: { fail('Operating System not supported.')}
      }
    }
    default: { fail('Operating System not supported.') }
  }

  if $source_dir != 'apt' {
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
  } else {
      package { "mysecureshell":
        ensure => 'installed',
      }
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
  file { '/etc/ssh/sftp.d/User-includes.conf':
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    ensure  => 'present',
  }->

  file { '/etc/ssh/sftp_config':
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    ensure  => 'present',
    content => "##########################################################
# THIS FILE IS MANAGED BY PUPPET - DO NOT EDIT MANUALLY! #
########################END###############################
Include /etc/ssh/sftp.d/default.conf	         #include default params
Include /etc/ssh/sftp.d/User-includes.conf     #includes single user conf files",
  }

  file_line { 'shell_entry':
    path    => '/etc/shells',
    line    => '/usr/bin/mysecureshell',
  }

  create_resources('sc_mysecureshell::config_tag', hiera_hash('sc_mysecureshell::config_tags', {}))

}
