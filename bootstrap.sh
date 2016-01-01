#!/bin/bash
set -e

g_ANSIBLE_REPOSITORY_URL="https://github.com/ansible/ansible.git"
g_ANSIBLE_CONFIG="/etc/ansible/ansible.cfg"
g_ANSIBLE_DIRECTORY="/home/vagrant/ansible"
g_ANSIBLE_BINARY="$g_ANSIBLE_DIRECTORY/bin/ansible"

install_ansible() {
    # Installing the release version Ansible is the easiest way to get all of
    # the dependencies. Also, we use the release version of Ansible to bootstrap
    # our configuration.
    yum -y install ansible git

    # Clone the repository
    if [ ! -f $g_ANSIBLE_BINARY ]; then
        pushd /home/vagrant
        sudo -u vagrant -H git clone $g_ANSIBLE_REPOSITORY_URL
        popd
    fi

    # Update to the latest development version
    pushd $g_ANSIBLE_DIRECTORY
    sudo -u vagrant -H git pull
    sudo -u vagrant -H git submodule update --init --recursive
    #shellcheck disable=SC1091
    popd

    # Source the development Ansible environment on login
    source_oneliner="source $g_ANSIBLE_DIRECTORY/hacking/env-setup"
    bashrc=/home/vagrant/.bash_profile
    if ! grep "$source_oneliner" $bashrc; then
        echo "$source_oneliner" >> $bashrc
    fi
}

set_ansible_config() {
    section=$1
    option=$2
    value=$3

    ansible localhost -c local -m ini_file \
        -a "dest=$g_ANSIBLE_CONFIG section='$section' option='$option' value='$value'"
}

install_ansible
mkdir -p /etc/ansible
touch g_ANSIBLE_CONFIG
set_ansible_config defaults host_key_checking False
set_ansible_config defaults inventory /vagrant/inventory.ini
set_ansible_config defaults remote_user vagrant

# Install Vagrant insecure keypair
g_VAGRANT_INSECURE_PUBLIC_KEY_URL='https://raw.githubusercontent.com/mitchellh/vagrant/master/keys/vagrant.pub'
g_VAGRANT_INSECURE_PRIVATE_KEY_URL='https://raw.githubusercontent.com/mitchellh/vagrant/master/keys/vagrant'
g_VAGRANT_SSH_DIRECTORY=/home/vagrant/.ssh
g_VAGRANT_PUBLIC_KEY=$g_VAGRANT_SSH_DIRECTORY/id_rsa.pub
g_VAGRANT_PRIVATE_KEY=$g_VAGRANT_SSH_DIRECTORY/id_rsa

download_vagrant_key() {
    url=$1
    file=$2

    if [ ! -f "$file" ]; then
        sudo -u vagrant -H curl -s "$url" -o "$file"
    fi
}

download_vagrant_key $g_VAGRANT_INSECURE_PUBLIC_KEY_URL $g_VAGRANT_PUBLIC_KEY
download_vagrant_key $g_VAGRANT_INSECURE_PRIVATE_KEY_URL $g_VAGRANT_PRIVATE_KEY

chmod 0600 $g_VAGRANT_PRIVATE_KEY
