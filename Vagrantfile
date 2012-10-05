# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
      config.vm.customize ["modifyvm", :id, "--name", "rvm", "--memory", "768"]
      
      config.vm.box = "precise32"
       
      config.vm.host_name = "rvm"
      
      config.vm.forward_port 22, 2222, :auto => true
      config.vm.forward_port 80, 4567
      
      config.ssh.max_tries = 150

      # Assign this VM to a host-only network IP, allowing you to access it
      # via the IP. Host-only networks can talk to the host machine as well as
      # any other machines on the same network, but cannot be accessed (through this
      # network interface) by any external networks.      
      config.vm.network :hostonly, "33.33.13.37"

      # Share an additional folder to the guest VM. The first argument is
      # an identifier, the second is the path on the guest to mount the
      # folder, and the third is the path on the host to the actual folder.
      config.vm.share_folder "ofina","/etc/ofina","../ofina_share"

      config.vm.boot_mode = :gui
end
