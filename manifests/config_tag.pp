# == Type: sc_mysecureshell::config_tag
#
# Defined type used to create single config tag for mysecureshell.
# For example used by scalecommerce-users module to create chrooted sftp-users.
#
# === Parameters
#
# [*type*]
#   Type of config tag - e. g. 'User' or 'Group'.
#
# [*attribute*]
#   Name attribute of config tag - e. g. username or groupname.
#
# [*settings*]
#   Array of key-value-pairs used for config settings
#
# === Examples
#
#  class { 'sc_mysecureshell::config_tag':
#    type => 'User',
#    attribute => 't.test',
#    settings => {
#      ['Home', '/var/www/www.shop.de/web'],
#      ['ForceUser', 'www-data'],
#    }
#  }
#
# --- or used by another puppet class:
#
# include sc_mysecureshell
# $sftpsettings = { 'Home' => 'somedir', 'ForceUser' => 'someusername' }
# sc_mysecureshell::config_tag { 'somename-config':
#   type      => 'User',
#   attribute => $username,
#   settings  => $sftpsettings,
# }
#
# --- hiera example
#
# classes:
#   - sc_mysecureshell
#
# sc_mysecureshell::config_tag:
#   type: 'User'
#   attribute: 't.test'
#   settings:
#     Home: '/var/www/www.shop.de/web'
#     ForceUser: 'www-data'
#
# === Authors
#
# Author Name <az@scale.sc>
#
# === Copyright
#
# Copyright ScaleCommerce GmbH 2016
#
define sc_mysecureshell::config_tag(
  $type,
  $attribute,
  $settings = {},
) {
  file {"/etc/ssh/sftp.d/$type-$attribute.conf":
    content => template("${module_name}/config_tag.conf.erb"),
  }
}