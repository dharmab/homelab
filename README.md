# Homelab

```
vagrant up
vagrant ssh ansible
# First run to bootstrap network services
ansible-playbook /vagrant/site.yml
# Second run to provision systems
ansible-playbook /vagrant/site.yml
```
