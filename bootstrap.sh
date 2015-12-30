#!/bin/bash
set -e

# Install Ansible
yum -y install ansible

set_ansible_config() {
    section=$1
    option=$2
    value=$3

    config="/etc/ansible/ansible.cfg"

    ansible localhost -c local -m ini_file \
        -a "dest=$config section='$section' option='$option' value='$value'"
}

set_ansible_config defaults host_key_checking False
set_ansible_config defaults inventory /vagrant/inventory.ini
set_ansible_config defaults remote_user vagrant

# Install Vagrant insecure private key
vagrant_insecure_public_key_url='https://raw.githubusercontent.com/mitchellh/vagrant/master/keys/vagrant.pub'
vagrant_insecure_private_key_url='https://raw.githubusercontent.com/mitchellh/vagrant/master/keys/vagrant'
vagrant_ssh_directory=/home/vagrant/.ssh
public_key=$vagrant_ssh_directory/id_rsa.pub
private_key=$vagrant_ssh_directory/id_rsa

download_vagrant_key() {
    url=$1
    file=$2

    if [ ! -f "$file" ]; then
        sudo -u vagrant -H curl -s "$url" -o "$file"
    fi
}

download_vagrant_key $vagrant_insecure_public_key_url $public_key
download_vagrant_key $vagrant_insecure_private_key_url $private_key

chmod 0600 $private_key
