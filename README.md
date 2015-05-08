# puppet-module-named

Puppet module to manage named - DNS services

===

# Compatibility

This module has been tested to work on the following systems using Puppet v3

 * EL7

===

# Example hiera config:

<pre>
named::chroot: false
named::forwarders:
  - 8.8.8.8
names::zonestatistcs: 'yes'
named::recursion: 'yes'
named::checknames: 'ignore'
named::ipv4listen:
  - any
named::ipv6listen:
  - any
named::allowquery:
  - any
named::allowquerycache:
  - any
named::allowtransfer:
  - any
named::dnssec: false
named::querylogfile: 'data/query.log'
named::rfc1912enabled: false
named::rndcenabled: true
named::zones:
  'example.com':
    type: 'master'
    file: 'data/example.com'
  'something.org:
    type: 'slave'
    file: 'slaves/something.org.db'
    masters:
      - 1.1.1.1
      - 2.2.2.2
</pre>

# Parameters


chroot
------
Configure the server as chroot

- *Default*: false

forwarders
----------
Array of addresses to use as forwarders

- *Default*: undef

zonestatistcs
-------------
Enabled zone-statistics, undef or 'yes'

- *Default*: undef

recursion
---------
Enable or disabled recursion, 'yes' or 'no'

- *Default*: 'yes'

checknames
----------
Control check-names, 'ignore'

- *Default*: undef

ipv4listen
----------
Array or addresses or any

- *Default*: [ '127.0.0.1', ],

ipv4port
--------
Port to listen in ipv4

- *Default*: '53'

ipv6listen
----------
Array or addresses or any

- *Default*: [ '::1', ],

ipv6port
--------
Port to listen in ipv6

- *Default*: '53'

allowquery
----------
Array of addresses or any

- *Default*: [ 'localhost', ],

allowquerycache
---------------
Array of addresses or any

- *Default*: undef

allowtransfer
-------------
Array of addresses or any

- *Default*: undef

dnssec
------
Enable or disable default dnssec config

- *Default*: true

namedconf
---------
Path for named.conf

- *Default*: '/etc/named.conf'


rfc1912enabled
--------------
Enable default rfc1912 config

- *Default*: true

rndcenabled
-----------
Enable default rndc config, files are created during package install

- *Default*: false

zones
-----
Array of zones to configure, see hiera example 

- *Default*: undef

¤¤¤
