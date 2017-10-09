# -*- mode: ruby -*-
# vim: set ft=ruby softtabstop=2 shiftwidth=2 expandtab :

Vagrant.configure(2) do |config|
  config.vm.box = "dharmab/centos7"

  config.vm.provider "virtualbox" do |virtualbox|
    # Save disk space by using linked clones
    virtualbox.linked_clone = true
  end

  config.vm.define "server-1", primary: true do |server|
    server.vm.hostname = "server-1"
    server.vm.network :private_network, ip: "10.10.10.10"

    # Provision as a Salt master
    server.vm.provision :shell, path: "bootstrap.sh", "args": ["master"]
    server.vm.synced_folder "salt", "/srv/salt"
    server.vm.synced_folder "pillar", "/srv/pillar"

    # Prometheus direct access at http://localhost:9090
    server.vm.network :forwarded_port, guest: 9090, host: 9090
    # Grafana direct access at http://localhost:3000
    server.vm.network :forwarded_port, guest: 3000, host: 3000
  end

  config.vm.define "server-2" do |server|
    server.vm.hostname = "server-2"
    server.vm.network :private_network, ip: "10.10.10.11"

    # Provision as a Salt minion
    server.vm.provision :shell, path: "bootstrap.sh", "args": ["minion"]
  end
end
