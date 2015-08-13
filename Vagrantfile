# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure('2') do |config|

  config.vm.provider :digital_ocean do |provider, override|
    override.ssh.private_key_path = '~/.ssh/id_rsa'
    override.vm.box = 'digital_ocean'
    override.vm.box_url = "https://github.com/smdahlen/vagrant-digitalocean/raw/master/box/digital_ocean.box"
    override.vm.hostname = 'purelypythonic.com'
    
    provider.ssh_key_name = 'robert@Robs-MBP.home' # change to whatever computer you're on
    provider.token = 'e3a1e8e02b63bf4f49793b743570585de5c95368624fc964ba64fc3e8110cf2f'
    provider.image = 'ubuntu-14-04-x64'
    provider.region = 'nyc3'
    provider.size = '512mb'
    provider.private_networking = true
  end

  config.vm.provision "shell", path: "scripts/vagrant-install.sh"
end
