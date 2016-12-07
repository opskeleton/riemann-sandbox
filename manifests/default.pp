group{ 'puppet': ensure  => present }

node 'riemann.local' {

  Service {
    provider => systemd
  }

  class{ 'riemann':
  } ->

  class { 'riemann::dash':
    host  => '0.0.0.0',
  }

  class { 'riemann::tools':
  }
}
