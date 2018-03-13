VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "generic/ubuntu1604"
  config.vm.network "forwarded_port", guest: 6379, host: 6379, auto_correct: true
  config.vm.provision "file", source: "./configuration", destination: "/tmp"
  
  config.vm.provider "hyperv" do |h|
    h.vmname = "Redis Local Forwarded Instance"
    h.memory = 256
    h.maxmemory = 1024
    h.vm_integration_services = {
        guest_service_interface: true,
        heartbeat: true,
        key_value_pair_exchange: true,
        shutdown: true,
        time_synchronization: true,
        vss: true
    }
  end

  config.vm.provider "virtualbox" do |v|
    v.customize ["modifyvm", :id, "--memory", "1024"]
    v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
  end

  config.vm.provision "shell", path: "init.sh"
end