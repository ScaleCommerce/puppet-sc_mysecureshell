# test users
describe user('jane') do
  it { should exist }
  its('uid') { should eq 10001 }
  its('group') { should eq 'users' }
  its('home') { should eq '/home/jane' }
  its('shell') { should eq '/bin/bash' }
end

describe user('john') do
  it { should exist }
  its('uid') { should eq 10002 }
  its('group') { should eq 'www-data' }
  its('home') { should eq '/home/john' }
  its('shell') { should eq '/usr/bin/mysecureshell' }
end

describe user('bob') do
  it { should exist }
  its('uid') { should eq 10003 }
  its('group') { should eq 'www-data' }
  its('home') { should eq '/home/bob' }
  its('shell') { should eq '/usr/bin/mysecureshell' }
end

# test commands
describe command('/usr/bin/mysecureshell --version') do
  its('stdout') { should match '/*MySecureShell is version 2.0/*' }
  its('exit_status') { should cmp 0 }
end

describe command('/usr/bin/sftp-admin') do
  it { should exist }
end

describe command('/usr/bin/sftp-kill') do
  it { should exist }
end

describe command('/usr/bin/sftp-state') do
  it { should exist }
end

describe command('/usr/bin/sftp-user') do
  it { should exist }
end

describe command('/usr/bin/sftp-verif') do
  it { should exist }
end

describe command('/usr/bin/sftp-who') do
  it { should exist }
end

# test config
describe file('/etc/ssh/sftp.d') do
  its('type') { should eq :directory }
end

describe file('/etc/ssh/sftp.d/default.conf') do
  its('type') { should eq :file }
  its('mode') { should cmp '00644' }
  its('owner') { should eq 'root' }
  its('group') { should eq 'root' }
end

describe file('/etc/ssh/sftp.d/User-includes.conf') do
  its('type') { should eq :file }
  its('mode') { should cmp '00644' }
  its('owner') { should eq 'root' }
  its('group') { should eq 'root' }
end

describe file("/etc/shells") do
  its(:content) { should match /\/usr\/bin\/mysecureshell/ }
end
