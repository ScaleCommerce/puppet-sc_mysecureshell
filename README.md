# sc_mysecureshell

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with dummy](#setup)
    * [What sc_mysecureshell affects](#what-sc_mysecureshell-affects)
    * [Beginning with sc_mysecureshell](#beginning-with-sc_mysecureshell)
4. [Limitations - OS compatibility, etc.](#limitations)

## Overview

The sc_mysecureshell module installs and configures mysecureshell (http://mysecureshell.readthedocs.io/).   
MySecureShell is a solution which has been made to bring more features to sftp/scp protocol 
given by OpenSSH. By default, OpenSSH brings a lot of liberty to connected users which imply 
to trust in your users. The goal of MySecureShell is to offer the power and security of OpenSSH, 
with enhanced features (like ACL) to restrict connected users.

## Module Description

Mysecureshell can not be installed as package by using apt. Binaries have to be compiled and installed. 
 So our module contains the precompiled binaries for Ubuntu 14.04 and 16.04. You may easily add further 
 binaries and put them into the files directory (subfolder: <$::operatingsystem>_<$::operatingsystemmajrelease>.  
 The main class simply copies the mysecureshell binaries into /usr/bin, sets the needed rights an adds 
 mysecureshell to /etc/shells. 
 It also creates the needed config file (/etc/ssh/sftp_config) which will by default contain only one 
 include on /etc/ssh/sftp.d/default.conf. The default config is done in config_tag.conf.erb template which 
 by now does not contain any variable but a suitable config for sftp purposes. Later on we will make 
 all parameters configurable.

## Setup

### What sc_mysecureshell affects

Following files will be copied to /usr/bin:  

- mysecureshell
- sftp-admin
- sftp-kill
- sftp-state
- sftp-user
- sftp-verif
- sftp-who

Following files and directories will be created:  

- /etc/ssh/sftp_config (main config file)
- /etc/ssh/sftp.d (directory for config include snippets)
- /etc/ssh/sftp.d/default.conf (default config)

Following files will be changed:  

- /etc/shells (adding /usr/bin/mysecureshell)

## Limitations

The Module contains binaries only for Ubuntu 14.04 and Ubuntu 16.04. If you need to 
install mysecureshell on different operating sytems you will have to compile and install 
it once manually and put the binaries int the apropriate subfolder inside the files directory.

