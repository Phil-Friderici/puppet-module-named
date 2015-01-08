# puppet-module-named

Puppet module to manage named - DNS services

===

# Compatibility

This module has been tested to work on the following systems using Puppet v3

 * EL7

===

# Example hiera config:

named::chroot: false
named::forwarders:
  - 8.8.8.8
named::recursion: true
named::acl:

¤¤¤
