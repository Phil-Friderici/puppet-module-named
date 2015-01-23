class named (
  $chroot           = false,
  $forwarders       = undef,
  $recursion        = 'yes',
  $checknames       = undef,
  $ipv4listen       = [ '127.0.0.1', ],
  $ipv4port         = '53',
  $ipv6listen       = [ '::1', ],
  $ipv6port         = '53',
  $allowquery       = [ 'localhost', ],
  $allowquerycache  = undef,
  $allowtransfer    = undef,
  $dnssec           = true,
  $namedconf        = '/etc/named.conf',
  $querylogfile     = undef,
  $rfc1912enabled   = true,
  $rndcenabled      = false,
  $zones            = undef,
) {

  if ($::operatingsystem == 'RedHat' and $::operatingsystemmajrelease == '7') {
    if ($chroot == true) {
      $packages = ['bind-chroot', 'bind', 'bind-utils', 'bind-license', 'bind-libs', 'bind-libs-lite', ]
    } else {
      $packages = ['bind', 'bind-utils', 'bind-license', 'bind-libs', 'bind-libs-lite', ]

      package {'bind-chroot':
        ensure  => absent,
      }
    }
  } else {
    fail("This module supports RedHat 7, you are running $::operatingsystem $::operatingsystemmajrelease")
  }

  package {$packages:
    ensure  => present,
  }

  if ($chroot == true) {
    service {'named':
      ensure  => stopped,
      enable  => false,
    }
    service {'named-chroot':
      ensure  => running,
      enable  => true,
      subscribe => File[$namedconf],
    }
  } else {
    service {'named':
      ensure  => running,
      enable  => true,
      subscribe => File[$namedconf],
    }
  } 

  file {$namedconf:
    ensure  => present,
    owner   => 'root',
    group   => 'named',
    mode    => '0640',
    content => template('named/named.conf.erb'),
  }

  if $querylogfile != undef {
    file {'/etc/logrotate.d/named-querylog':
      ensure  => present,
      owner   => 'root',
      group   => 'named',
      mode    => '0640',
      content => template('named/named-querylog.erb'),
    }
  } else {
    file {'/etc/logrotate.d/named-querylog':
      ensure  => absent,
    }
  }
}
