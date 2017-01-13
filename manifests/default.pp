group{ 'puppet': ensure  => present }

node 'riemann.local' {
  include apt
  include git
  include shell
  include vim

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
