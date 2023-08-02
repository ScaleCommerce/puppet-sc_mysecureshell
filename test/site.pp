lookup('classes')

# resource wrapper
$files=lookup('files', {})
create_resources(file, $files)

$crons=lookup('crons', {})
create_resources(cron, $crons)

$execs=lookup('execs', {})
create_resources(exec, $execs)

$hosts=lookup('hosts', {})
create_resources(host, $hosts)

$mounts=lookup('mounts', {})
create_resources(mount, $mounts)

$packages=lookup('packages', {})
create_resources(package, $packages)

$services=lookup('services', {})
create_resources(service, $services)
