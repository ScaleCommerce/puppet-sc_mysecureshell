lookup('classes')

# resource wrapper
$files=lookup('files', undef, undef, {})
create_resources(file, $files)

$crons=lookup('crons', undef, undef, {})
create_resources(cron, $crons)

$execs=lookup('execs', undef, undef, {})
create_resources(exec, $execs)

$hosts=lookup('hosts', undef, undef, {})
create_resources(host, $hosts)

$mounts=lookup('mounts', undef, undef, {})
create_resources(mount, $mounts)

$packages=lookup('packages', undef, undef, {})
create_resources(package, $packages)

$services=lookup('services', undef, undef, {})
create_resources(service, $services)
