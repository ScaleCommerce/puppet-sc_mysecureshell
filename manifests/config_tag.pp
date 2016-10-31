define config_tag(
  $type,
  $attribute,
  $settings = {},

) {


  file {"/etc/ssh/sftp.d/$type-$attribute.conf":

    content => template("${module_name}/config_tag.conf.erb"),

  }


}