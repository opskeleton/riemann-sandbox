# -*- mode: ruby -*-
# vi: set ft=ruby :
update = <<SCRIPT
if [ ! -f /tmp/up ]; then
  sudo aptitude update 
  touch /tmp/up
fi
SCRIPT

Vagrant.configure("2") do |config|

  bridge = ENV['VAGRANT_BRIDGE']
  bridge ||= 'eth0'
  env  = ENV['PUPPET_ENV']
  env ||= 'dev'

  config.vm.box = 'ubuntu-14.04_puppet-3.6.1' 
  config.vm.network :public_network, :bridge => bridge
  config.vm.hostname = 'riemann.local'

  config.vm.provider :virtualbox do |vb|
    vb.customize ['modifyvm', :id, '--memory', 2048, '--cpus', 2]
  end

  config.vm.provision :shell, :inline => update
  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = 'manifests'
    puppet.manifest_file  = 'default.pp'
    puppet.options = '--modulepath=/vagrant/modules:/vagrant/static-modules --hiera_config /vagrant/hiera_vagrant.yaml --environment=#{env}'

  end

end
