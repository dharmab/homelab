#!/bin/bash
set -e

set_ansible_config() {
    section=$1
    option=$2
    value=$3

    ansible localhost -i /etc/ansible/hosts -c local -m ini_file -a "dest=/etc/ansible/ansible.cfg section=$section option=$option value=$value"
}

install_ansible() {
    ansible_repository_url="https://github.com/ansible/ansible.git"
    ansible_directory="/home/vagrant/ansible"

    # Installing the release version Ansible is the easiest way to get all of
    # the dependencies. Also, we use the release version of Ansible to bootstrap
    # our configuration.
    yum -y install ansible git
    set_ansible_config defaults host_key_checking False
    set_ansible_config defaults inventory /vagrant/inventory.ini
    set_ansible_config defaults remote_user vagrant

    # Clone the repository
    if [ ! -d $ansible_directory ]; then
        pushd /home/vagrant
        sudo -u vagrant -H git clone $ansible_repository_url
        popd
    fi

    # Update to the latest development version
    pushd $ansible_directory
    sudo -u vagrant -H git pull
    sudo -u vagrant -H git submodule update --init --recursive
    #shellcheck disable=SC1091
    popd

    # Source the development Ansible environment on login
    env_oneliner="source $ansible_directory/hacking/env-setup"
    profile=/home/vagrant/.bash_profile
    if ! grep "$env_oneliner" $profile; then
        echo "$env_oneliner" >> $profile
    fi
}


download_vagrant_key() {
    url=$1
    file=$2

    if [ ! -f "$file" ]; then
        sudo -u vagrant -H curl -s "$url" -o "$file"
    fi
}

download_vagrant_keys() {
    # Install Vagrant insecure keypair
    vagrant_insecure_public_key_url='https://raw.githubusercontent.com/mitchellh/vagrant/master/keys/vagrant.pub'
    vagrant_insecure_private_key_url='https://raw.githubusercontent.com/mitchellh/vagrant/master/keys/vagrant'
    vagrant_ssh_directory=/home/vagrant/.ssh
    vagrant_public_key=$vagrant_ssh_directory/id_rsa.pub
    vagrant_private_key=$vagrant_ssh_directory/id_rsa

    download_vagrant_key $vagrant_insecure_public_key_url $vagrant_public_key
    download_vagrant_key $vagrant_insecure_private_key_url $vagrant_private_key

    chmod 0600 $vagrant_private_key
}

install_ansible
download_vagrant_keys
