#!/bin/bash

role="$1"

echo "Starting firewall"
systemctl start firewalld

echo "Configuring SaltStack repository"
yum install -y https://repo.saltstack.com/yum/redhat/salt-repo-latest-2.el7.noarch.rpm 
yum clean -y expire-cache

echo "Configuring Salt minion"
yum install -y salt-minion
cat << EOF > /etc/salt/minion
master: 10.10.10.10
EOF
systemctl restart salt-minion
systemctl enable salt-minion

echo "Configuring Salt master"
if [[ "$role" == "master" ]]; then
    yum install -y salt-master
    cat << EOF > /etc/salt/master
open_mode: True
EOF
    firewall-cmd --zone=public --add-port 4505-4506/tcp
    systemctl restart salt-master
    systemctl enable salt-master
fi
