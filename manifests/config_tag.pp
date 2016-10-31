# settings should have format:
# settings['key'] => 'foo'
# settings['value'] => 'bar'

define config_tag(
  $type,
  $attribute,
  $settings = {},

) {


  file {"/etc/ssh/sftp.d/$type-$attribute.conf":

    content => template("${module_name}/config-tag.conf.erb"),

  }


}