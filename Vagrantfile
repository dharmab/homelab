# -*- mode: ruby -*-
# vim: set ft=ruby softtabstop=2 shiftwidth=2 expandtab :

##
# Compose a local IPv6 address
# The prefix, local bit and global ID are defined in compliance with RFC 4193
# The 16-bit +subnet_id+ and 64-bit +interface_id+ values are combined with the
# prefix, local bit and global ID to create the IP address.
# Returns the IPv6 address as a string.
def get_ip_address(interface_id, subnet_id=0)
  # Each hexadecimal digit encodes 4 bits
  # 16-bit subnet ID = 4 characters
  subnet_id_as_hex = subnet_id.to_s(16).rjust(4, "0")
  # 64-bit interface ID = 16 characters
  interface_id_as_hex = interface_id.to_s(16).rjust(16, "0")

  # Use scan and join to insert a colon between each 4 characters
  "fdfefdb48152#{subnet_id_as_hex}#{interface_id_as_hex}".scan(/.{4}/).join(":")
end

Vagrant.configure(2) do |config|
  config.vm.box = "dharmab/centos7"

  # Gateway
  config.vm.define "router" do |router|
    ip = get_ip_address(10)
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
