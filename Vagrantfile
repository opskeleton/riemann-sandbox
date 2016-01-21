# -*- mode: ruby -*-
# vi: set ft=ruby :
update = <<SCRIPT
if [ ! -f /tmp/up ]; then
  sudo aptitude update 
  touch /tmp/up
fi
SCRIPT

ENV['VAGRANT_DEFAULT_PROVIDER'] ||= 'libvirt'

Vagrant.configure("2") do |config|

  env  = ENV['PUPPET_ENV'] || 'dev'
  device = ENV['VAGRANT_BRIDGE'] || 'eth0'
  pool = ENV['VAGRANT_POOL'] 

  config.vm.box = 'ubuntu-15.10_puppet-3.8.2' 
  config.vm.hostname = 'riemann.local'

  config.vm.provider :virtualbox do |vb|
    vb.customize ['modifyvm', :id, '--memory', 2048, '--cpus', 2]
  end

  config.vm.provider :libvirt do |domain, override|
    override.vm.network :public_network, :bridge => device , :dev => device
    domain.uri = 'qemu+unix:///system'
    domain.memory = 2048
    domain.cpus = 2
    domain.storage_pool_name = pool if pool
    override.vm.synced_folder './', '/vagrant', type: 'nfs'
 end


  config.vm.provision :shell, :inline => update
  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = 'manifests'
    puppet.manifest_file  = 'default.pp'
    puppet.options = "--modulepath=/vagrant/modules:/vagrant/static-modules --hiera_config /vagrant/hiera_vagrant.yaml --environment=#{env}"

  end

end
