# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2" 

machines = [
  {
    :hostname => "swarmstore",
    :ip => "192.168.56.10",
    :box => "ubuntu/jammy64",
    :ram => 1024,
    :cpu => 1,
    :disk => "100GB"
  },
  {
    :hostname => "swarmhost2",
    :ip => "192.168.56.12",
    :box => "ubuntu/jammy64",
    :ram => 1024,
    :cpu => 1,
    :disk => "100GB"
  },
  {
    :hostname => "swarmhost3",
    :ip => "192.168.56.13",
    :box => "ubuntu/jammy64",
    :ram => 1024,
    :cpu => 1,
    :disk => "100GB"
  },
  {
    :hostname => "swarmhost4",
    :ip => "192.168.56.14",
    :box => "ubuntu/jammy64",
    :ram => 1024,
    :cpu => 1,
    :disk => "100GB"
  }
]

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

    # exposing ports so need to create this one on its own
    config.vm.define "swarmhost1" do |node|
        node.vm.box = "ubuntu/jammy64"
        node.vm.hostname = "swarmhost1"
        node.vm.disk :disk, size: "100GB", primary: true
        node.vm.network "private_network", ip: "192.168.56.11"
        node.vm.network "forwarded_port", guest: "53", host: "53"
        node.vm.network "forwarded_port", guest: "80", host: "80"
        node.vm.network "forwarded_port", guest: "443", host: "443"
        node.vm.provision "ansible" do |ansible|
            ansible.limit = "all"
            ansible.playbook ="playbooks/init.yaml"
        end
        node.vm.provider "virtualbox" do |vb|
            vb.customize ["modifyvm", :id, "--memory", 1024]
        end
    end

    machines.each do |machine|
        config.vm.define machine[:hostname] do |node|
            node.vm.box = machine[:box]
            node.vm.hostname = machine[:hostname]
            node.vm.disk :disk, size: machine[:disk], primary: true
            node.vm.network "private_network", ip: machine[:ip]
            node.vm.provision "ansible" do |ansible|
                # ansible.limit = "all" # required to access vars from other hosts
                ansible.playbook ="playbooks/init.yaml"
            end
            node.vm.provider "virtualbox" do |vb|
                vb.customize ["modifyvm", :id, "--memory", machine[:ram]]
            end
        end
    end
end
