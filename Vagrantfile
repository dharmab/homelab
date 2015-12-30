# -*- mode: ruby -*-
# vim: set ft=ruby softtabstop=2 shiftwidth=2 expandtab :

##
# Compose a local IPv4 address
# +subnet_id+ is the first three octets of the address as a string, (e.g.
# '192.168.10', and the +interface_id+ is the fourth octet as a string or
# integer (e.g. 25 or '25')
# Returns the IPv4 address as a string.
def get_ip_address(interface_id, subnet_id='10.10.10')
  if subnet_id[-1, 1] != '.'
    subnet_id << '.'
  end

  "#{subnet_id}#{interface_id}"
end

Vagrant.configure(2) do |config|


  config.vm.box = "dharmab/centos7"

  config.vm.provider 'virtualbox' do |virtualbox|
    # Save disk space by using linked clones
    # The drawback is reduced disk I/O... but I have SSDs :D
    virtualbox.linked_clone = true if Vagrant::VERSION =~ /^1.8/
  end
  # Gateway
  config.vm.define "router" do |router|
    ip = get_ip_address(1)
    router.vm.network :private_network, ip: ip
  end

  # DNS Master
  config.vm.define "dnsmaster" do |dns|
    dns.vm.network :private_network, ip: get_ip_address(2)
  end

  # DNS Slave
  config.vm.define "dnsslave" do |dns|
    dns.vm.network :private_network, ip: get_ip_address(3)
  end

  # Configuration Management
  config.vm.define "ansible" do |ansible|
    ansible.vm.network :private_network, ip: get_ip_address(4)
    ansible.vm.provision :shell, inline: "yum -y install ansible"
  end

end
