class named (
  $chroot           = false,
  $forwarders       = undef,
  $recursion        = undef,
  $ipv4listen       = 'none',
  $ipv4port         = '53',
  $ipv6listen       = 'none',
  $ipv6port         = '53',
  $acl              = undef,
  $allowquery       = undef,
  $allowquerycache  = undef,
  $allowtransfer    = undef,
  $allowupdate      = undef,
  $namedconf        = '/etc/named.conf',
  $namedzones       = '/etc/named.zones',
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
      ensure  => started,
      enable  => true,
    }
  } else {
    service {'named':
      ensure  => started,
      enable  => true,
    }
  } 

  file {$namedconf:
    ensure  => present,
    
  }

  file {$namedzones:
    ensure  => present,

  }
}
