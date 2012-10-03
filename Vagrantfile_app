# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
      config.vm.customize ["modifyvm", :id, "--name", "app", "--memory", "512"]
      config.vm.box = "precise32_with_ruby193"
      config.vm.host_name = "app"
      config.vm.forward_port 22, 2222, :auto => true
      config.vm.forward_port 80, 4567      
      config.vm.network :hostonly, "33.33.13.37"
      config.vm.share_folder "ofina","/etc/ofina","../ofina_share"
      config.vm.boot_mode = :gui
end
